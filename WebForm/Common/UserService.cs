﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace WebForm.Common
{
    public class UserService
    {
        public void CreateAllUser(string number1)
        {
            var number = Convert.ToInt32(number1);
            var ss = new FoWoSoft.Platform.Guid_id().GetAll();

            for (int i = number; i < ss.Count; i++)
            {

                if (i > number + 10) break;
                Task.Factory.StartNew(new Action(() =>
                {
                    var users = new EduWebService().GetAllUserByDPCODE(ss[i].useId.Trim());
                    if (users.Columns.Count > 1 && users.Rows.Count > 0)
                    {
                        for (int j = 0; j < users.Rows.Count; j++)
                        {
                            CreateNewUser(users.Rows[j][0].ToString());
                        }
                    }
                }));


            }
        }
        public void CreateUser(string number1)
        {
             
                    var users = new EduWebService().GetAllUserByDPCODE(number1);
                    if (users.Columns.Count > 1 && users.Rows.Count > 0)
                    {
                        for (int j = 0; j < users.Rows.Count; j++)
                        {
                            CreateNewUser(users.Rows[j][0].ToString());
                        }
                    }
                


           
        }
        public FoWoSoft.Data.Model.Users CreateNewUser(string userid)
        {
            var user = new FoWoSoft.Platform.Users().GetByAccount(userid);
            if (user != null) return user;

            //根据UserId获取从远程用户信息
            var userInfoEdu = new EduWebService().GetUser(userid);
            if (userInfoEdu == null) return null;
            //更新用户信息
            user = new FoWoSoft.Data.Model.Users()
            {
                Account = userid,
                ID = Guid.NewGuid(),
                Name = userInfoEdu.XM,
                Status = 0,
                Password = "1234",
                Sort = 1,
                Note = ""
            };

            new FoWoSoft.Platform.Users().Add(user);
            //创建组织关系
            var guidId = new FoWoSoft.Platform.Guid_id().Get(userInfoEdu.BMBH);
            new FoWoSoft.Platform.UsersRelation().Add(new FoWoSoft.Data.Model.UsersRelation()
            {
                OrganizeID = guidId.GuidId,
                UserID = user.ID,
                Sort = 1,
                IsMain = 1
            });
            //更新组织下人员的个数
            new FoWoSoft.Platform.Organize().UpdateChildsLength(guidId.GuidId);
            //创建用户角色
            new FoWoSoft.Platform.UsersRole().Add(new FoWoSoft.Data.Model.UsersRole()
            {
                RoleID = Guid.Parse("0CF2ABB1-5F90-4FB3-8FA9-B53628B92879"),
                MemberID = user.ID,
                IsDefault = true
            });
            return user;
        }
    }
}