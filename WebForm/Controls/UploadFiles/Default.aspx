﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebForm.Controls.UploadFiles.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <% 
    string extName = Request.QueryString["filetype"];
    string tmpID = Guid.NewGuid().ToString("N");
    string tmpID1 = FoWoSoft.Platform.Users.CurrentUserID.ToString();
    FoWoSoft.Cache.IO.Opation.Set(tmpID, tmpID1);
    %>
        <script src="Uploadify/jquery.uploadify.js?v=<%=FoWoSoft.Utility.DateTimeNew.Now.Ticks %>" type="text/javascript"></script>
        <style type="text/css">
            .uploadify-ico{border:none 0;vertical-align:middle;margin-right:3px;}
        </style>
        <table cellpadding="0" cellspacing="1" border="0" width="98%" align="center" style="margin-top:8px;">
            <tr>
                <td style="height:40px;" id="uploadtable"><input id="file_upload" name="file_upload" type="file" multiple="true" /></td>
                <td align="right" style="padding-right:20px;">
                    <input type="button" class="mybutton" value="删除所选" onclick="delselect()" />
                    <input type="button" class="mybutton" value="&nbsp;确&nbsp;&nbsp;认&nbsp;" onclick="confirm1();" />
                    <input type="button" class="mybutton" value="&nbsp;关&nbsp;&nbsp;闭&nbsp;" onclick="closewin();" />
                </td>
            </tr>
        </table>
        <div id="queue" style="margin:0 auto 5px 0;"></div>
        <div id="filelist">
            <table cellpadding="0" cellspacing="1" border="0" id="filetable" width="98%" class="listtable" style="width:98%; margin:0 auto;">
                <thead>
                    <tr>
                        <th style="width:70%">文件</th>
                        <th style="width:20%">大小(KB)</th>
                        <th><input type="checkbox" id="checkall" onclick="checkallbox(this);" style="vertical-align:middle;" />删除</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    string files = Request.QueryString["files"];
                    if (!files.IsNullOrEmpty())
                    {
                        string[] filesArray = files.Split('|');
                        foreach (string file in filesArray)
                        {
                            string size = FoWoSoft.Utility.Tools.GetFileSize(Server.MapPath(file));
                 %>
                    <tr>
                        <td style="background:#ffffff;"><a target="_blank" href="<%=file %>"><img alt="" class="uploadify-ico" src="../../Images/ico/doc_stand.png" style="border:none;" /><%=file.Substring(file.LastIndexOf('/')+1) %></a></td>
                        <td style="background:#ffffff;"><%=size %></td>
                        <td style="background:#ffffff;"><input type="checkbox" name="delfile" value="<%=file %>" /></td>
                    </tr>
                 <%
                        }
                    }    
                 %>
                </tbody>
            </table>
        </div>
	    <script type="text/javascript">
	        var win = new RoadUI.Window();
	        var eid = '<%=Request.QueryString["eid"]%>';
	        $(function ()
	        {
	            $('#file_upload').uploadify({
	                'formData': { "str1": "<%=tmpID%>", "str2": "<%=tmpID1%>", "filetype": "<%=extName%>" },
	                'swf': 'Uploadify/uploadify.swf' + '?ver=' + new Date().toString(),
	                'uploader': 'Upload.ashx',
	                'buttonText': '添加文件',
	                'fileTypeDesc': '文件',
	                'fileTypeExts': '<%=extName%>',
	                'auto': true,
	                'multi': true,
	                'queueID': 'queue',
	                'onUploadSuccess': function (file, data, response)
	                {
	                    var dataArray = data.split('|');
	                    if (dataArray.length > 0 && dataArray[0] == "1")
	                    {
	                        addFile(file, dataArray);
	                    }
	                    else
	                    {
	                        alert(data);
	                    }
	                },
	                'onSelect': function ()
	                {
	                    $("#queue").show();
	                },
	                'onQueueComplete': function ()
	                {
	                    $("#queue").hide(1000);
	                }
	            });
	        });
	        function addFile(file, dataArray)
	        {
	            if (dataArray.length != 4) return;
	            var tr = '<tr>';
	            tr += '<td style="background:#ffffff;">';
	            tr += '<a href="' + dataArray[1] + '" target="_blank">';
	            tr += '<img src="../../Images/ico/doc_stand.png" alt="" class="uploadify-ico" />';
	            tr += dataArray[3];
	            tr += '</a>';
	            tr += '</td>';
	            tr += '<td style="background:#ffffff;">';
	            tr += dataArray[2];
	            tr += '</td>';
	            tr += '<td style="background:#ffffff;">';
	            tr += '<input type="checkbox" name="delfile" value="' + dataArray[1] + '" />';
	            tr += '</td>';
	            tr += '</tr>';
	            $("#filetable tbody").append(tr);
	            return false;
	        }
	        function checkallbox(box)
	        {
	            $("input[name='delfile']").prop("checked", $(box).prop("checked"));
	        }
	        function confirm1()
	        {
	            var title = [];
	            var value = [];
	            $("#filetable tbody tr").each(function ()
	            {
	                var filename = $("td:eq(0)", $(this)).text();
	                var filepathname = $("input[name='delfile']", $(this)).val();
	                title.push(filename);
	                value.push(filepathname);
	            });
	            var ele = win.getOpenerElement(eid);
	            var ele1 = win.getOpenerElement(eid + "_text");
	            if (ele1 != null && ele1.size() > 0)
	            {
	                ele1.val('共' + value.length + '个文件');
	            }
	            if (ele != null && ele.size() > 0)
	            {
	                ele.val(value.join('|'));
	            }
	            closewin();
	        }
	        function closewin()
	        {
	            try
	            {
	                $('#file_upload').uploadify('destroy');
	            } catch (e)
	            {

	            }
	            win.close();
	        }
	        function delselect()
	        {
	            if ($(":checkbox[name='delfile']:checked").size() == 0)
	            {
	                alert("您没有选择要删除的文件!"); return;
	            }
	            $(":checkbox[name='delfile']:checked").each(function ()
	            {
	                var box = $(this);
	                var file = box.val();
	                $.getScript("Delete.ashx?file=" + file+"&str1=<%=tmpID%>&str2=<%=tmpID1%>", function ()
	                {
	                    if ("1" == json.success)
	                    {
	                        box.parent().parent().remove();
	                    }
	                    else
	                    {
	                        alert(json.message);
	                    }
	                });
	            });
	        }
	    </script>

    </form>
</body>
</html>
