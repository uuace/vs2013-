﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebForm.Tests
{
    /// <summary>
    /// Combox_GetTable 的摘要说明
    /// </summary>
    public class Combox_GetTable : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string title = context.Request.QueryString["title"];
            string page;
            System.Data.DataTable dt = new FoWoSoft.Platform.Log().GetPagerData(out page, "", title, "", "", "", "");
            System.Text.StringBuilder sb = new System.Text.StringBuilder();

            foreach (System.Data.DataRow user in dt.Rows)
            {
                sb.Append("<tr><td value='" + user["ID"] + "'>" + user["Title"] + "</td><td>" + user["Type"] + "</td><td>" + user["UserName"] + "</td><td>" + user["WriteTime"] + "</td></tr>");
            }
            context.Response.Write("{\"count\":" + new FoWoSoft.Platform.Log().GetCount() + ",\"data\":\"" + sb.ToString() + "\"}");
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}