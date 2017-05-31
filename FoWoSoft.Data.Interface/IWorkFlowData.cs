﻿using System;
using System.Collections.Generic;

namespace FoWoSoft.Data.Interface
{
    public interface IWorkFlowData
    {
        /// <summary>
        /// 新增
        /// </summary>
        int Add(FoWoSoft.Data.Model.WorkFlowData model);

        /// <summary>
        /// 更新
        /// </summary>
        int Update(FoWoSoft.Data.Model.WorkFlowData model);

        /// <summary>
        /// 查询所有记录
        /// </summary>
        List<FoWoSoft.Data.Model.WorkFlowData> GetAll();

        /// <summary>
        /// 查询单条记录
        /// </summary>
        Model.WorkFlowData Get(Guid id);

        /// <summary>
        /// 删除
        /// </summary>
        int Delete(Guid id);

        /// <summary>
        /// 查询记录条数
        /// </summary>
        long GetCount();

        /// <summary>
        /// 查询一个实例ID所有记录
        /// </summary>
        List<FoWoSoft.Data.Model.WorkFlowData> GetAll(Guid instanceID);
    }
}
