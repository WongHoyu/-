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
    init(text:String = "", checked:Bool = false, dueDate:Date = Date(), shouldRemind:Bool = false, level:Int = 0) {
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
    
    //从nsobject解析回来
    init(coder aDecoder:NSCoder!) {
        self.text = aDecoder.decodeObject(forKey: "Text") as! String
        self.checked = aDecoder.decodeObject(forKey: "Checked") as! Bool
        self.dueDate = aDecoder.decodeObject(forKey: "DueDate") as! Date
        self.shouldRemind = aDecoder.decodeObject(forKey: "ShouldRemaind") as! Bool
        self.itemId = aDecoder.decodeObject(forKey: "ItemId") as! Int
        self.level = aDecoder.decodeObject(forKey: "Level") as! Int
    }
    
    //编码object
    func encodeWith(aCoder:NSCoder!) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")
        aCoder.encode(dueDate, forKey: "DueDate")
        aCoder.encode(shouldRemind, forKey: "ShouldRemaind")
        aCoder.encode(itemId, forKey: "ItemId")
        aCoder.encode(level, forKey: "Level")
    }
    
    /// 发送通知消息
    func scheduleNotification() {
        /*
         那dueDate和NSDate.date比较，如果结果是OrderedAscending，
         表示dueDate的时间比当前早，即过期，不需要再提醒
         */
        //OrderedDescending 保存的dueDate比当前时间晚
        //OrderedSame 保存的dueDate与当前时间相同
        if self.shouldRemind && (self.dueDate.compare(Date.init()) != ComparisonResult.orderedAscending) {
            print("当前任务时间到")
        }
    }
}
