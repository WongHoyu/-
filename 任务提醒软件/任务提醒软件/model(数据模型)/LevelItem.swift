//
//  LevelItem.swift
//  任务提醒软件
//
//  Created by WongHoyu on 2018/5/24.
//  Copyright © 2018年 hwanghaoyu. All rights reserved.
//

import UIKit

class LevelItem: NSObject {
    //重视程度
    var level:Int
    
    //重视程度的标题
    var title:String = ""
    
    //cell是否被勾选
    var checkMark:Bool = false
    
    init(level:Int) {
        self.level = level
        self.title = LevelItem.onGetTitle(level: level)
        
    }
    
    class func onGetTitle(level:Int) -> String {
        var title:String = ""
        switch level {
        case 0:
            title = "非常重要"
        case 1:
            title = "很重要"
        case 2:
            title = "重要"
        case 3:
            title = "一般"
        case 4:
            title = "可忽略"
        default:
            title = "非常重要"
        }
        return title
    }
}
