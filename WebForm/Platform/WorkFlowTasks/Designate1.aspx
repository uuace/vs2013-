﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Designate1.aspx.cs" Inherits="WebForm.Platform.WorkFlowTasks.Designate1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
      <div style="text-align:center; padding-top:50px;padding-right:50px">
        指派给：<input type="text" class="mymember" style="width:140px;" id="user" name="user" validate="empty" errmsg="请选择要指派的人员"  value="" />
        <input style="margin-left:50px;" type="submit" class="mybutton" value="确&nbsp;定" onclick="return new RoadUI.Validate().validateForm(document.forms[0]);" />
        <span type="msg"></span>
        </div>
    </div>
    </form>
</body>
</html>
