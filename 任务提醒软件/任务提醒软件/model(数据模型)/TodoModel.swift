//
//  TodoModel.swift
//  任务提醒软件
//
//  Created by WongHoyu on 2018/5/10.
//  Copyright © 2018年 hwanghaoyu. All rights reserved.
//

import UIKit

class TodoModel: NSObject {
    //记录任务分类的数据
    var typeList = [TypeItem]()
    
    //构造方法
    override init() {
        super.init()
        //初始化模拟数据
        onCreateData()
    }
    
    /// 创建模拟数据
    func onCreateData() {
        for i in 0...9 {
            let name = "任务: \(i)"
            let type = TypeItem(name: name)
            typeList.append(type)
        }
    }
    
    /// 增加分类的方法
    ///
    /// - Parameter type: 任务类型
    func onAddType(type:TypeItem) {
        typeList.append(type)
    }
}

//创建全局数据
var todoModel = TodoModel()
