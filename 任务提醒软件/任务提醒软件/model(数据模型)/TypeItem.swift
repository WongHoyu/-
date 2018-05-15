//
//  TypeItem.swift
//  任务提醒软件
//
//  Created by WongHoyu on 2018/5/10.
//  Copyright © 2018年 hwanghaoyu. All rights reserved.
//

import UIKit

class TypeItem: NSObject {
    //任务清单数据
    var items = [TodoItem]()
    
    //任务分类
    var name:String = ""
    
    //分类图标
    var icon:String = "提醒"
    
    //构造方法
    init(name:String) {
        super.init()
        self.name = name
    }
    
    
}
