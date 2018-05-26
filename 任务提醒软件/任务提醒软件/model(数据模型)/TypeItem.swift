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
    
    ///计算该类任务还有多少item没有勾选
    func countUncheckedItems() -> Int {
        var count = 0
        for item in items {
            if item.checked != true {
                count += 1
            }
        }
        return count
    }
    
    //从nsobject解析回来
    init(coder aDecoder:NSCoder!) {
        self.name = aDecoder.decodeObject(forKey: "Name") as! String
        self.items = aDecoder.decodeObject(forKey: "Items") as! [TodoItem]
        self.icon = aDecoder.decodeObject(forKey: "icon") as! String
    }
    
    //编码object
    func encodeWith(aCoder:NSCoder!) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(items, forKey: "Item")
        aCoder.encode(icon, forKey: "Icon")
    }
    
}
