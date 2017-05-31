﻿using System;
using System.Collections.Generic;

namespace FoWoSoft.Data.Interface
{
    public interface IWorkGroup
    {
        /// <summary>
        /// 新增
        /// </summary>
        int Add(FoWoSoft.Data.Model.WorkGroup model);

        /// <summary>
        /// 更新
        /// </summary>
        int Update(FoWoSoft.Data.Model.WorkGroup model);

        /// <summary>
        /// 查询所有记录
        /// </summary>
        List<FoWoSoft.Data.Model.WorkGroup> GetAll();

        /// <summary>
        /// 查询单条记录
        /// </summary>
        Model.WorkGroup Get(Guid id);

        /// <summary>
        /// 删除
        /// </summary>
        int Delete(Guid id);

        /// <summary>
        /// 查询记录条数
        /// </summary>
        long GetCount();
    }
}
