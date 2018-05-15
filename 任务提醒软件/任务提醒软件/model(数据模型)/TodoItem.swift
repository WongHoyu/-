//
//  TodoItem.swift
//  任务提醒软件
//
//  Created by WongHoyu on 2018/5/15.
//  Copyright © 2018年 hwanghaoyu. All rights reserved.
//

import UIKit

class TodoItem: NSObject {
    //任务名称
    var text:String
    
    //是否完成
    var checked:Bool
    
    //提醒时间
    var dueDate:Date
    
    //是否提醒
    var shouldRemind:Bool
    
    //任务id
    var itemId:Int
    
    //级别
    var level:Int = 0
    
    //构造方法
    init(text:String, checked:Bool, dueDate:Date, shouldRemind:Bool, level:Int) {
        self.text = text
        self.checked = checked
        self.dueDate = dueDate
        self.shouldRemind = shouldRemind
        self.itemId = TodoModel.nextTodoItemId()
        self.level = level
        super.init()
    }
    
    //设置是否完成属性
    func onChangeChecked() {
        self.checked = !self.checked
    }
}
