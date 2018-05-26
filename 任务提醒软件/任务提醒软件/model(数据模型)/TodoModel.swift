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
        print("沙盒文件夹路径: \(documentsDirectory())")
        print("数据文件路径: \(dataFilePath())")
        //初始化模拟数据
        //onCreateData()
        loadData()
    }
    
//    /// 创建模拟数据
//    func onCreateData() {
//        for i in 1...10 {
//            let name = "任务: \(i)"
//            let type = TypeItem(name: name)
//            for j in 0...4 {
//                let todo = TodoItem(text: "任务清单: \(j)", checked: false, dueDate: Date(), shouldRemind: true, level: 0)
//                type.items.append(todo)
//            }
//            typeList.append(type)
//        }
//    }
    
    /// 获取沙盒路径
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory:String = paths.first!
        print(documentsDirectory)
        return documentsDirectory
    }
    
    /// 获取数据文件地址
    func dataFilePath() -> String{
        return documentsDirectory() + "todo.plist"
    }
    
    /// 保存数据
    func saveData() {
        let data = NSMutableData()
        //声明一个归档处理对象
        let archiver = NSKeyedArchiver(forWritingWith: data)
        //将lists以对应Checklist关键字进行编码
        archiver.encode(typeList, forKey: "todolist")
        //编码结束
        archiver.finishEncoding()
        //数据写入
        data.write(toFile: dataFilePath(), atomically: true)
    }
    
    func loadData() {
        //获取本地数据文件地址
        let path = self.dataFilePath()
        //声明文件管理器
        let defaultManager = FileManager()
        //通过文件地址判断数据文件是否存在
        if defaultManager.fileExists(atPath: path) {
            //读取文件数据
            let data = NSData(contentsOfFile: path)
            //解码器
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data! as Data)
            //通过归档时设置的关键字checklist还原liats
            typeList = unarchiver.decodeObject(forKey: "todolist") as! Array
            //结束解码
            unarchiver.finishDecoding()
        } else {
            //如果文件不存在，则是第一次安装该应用，创建一个checklist
            let type = TypeItem(name: "女神有关")
            typeList.append(type)
            saveData()
        }
    }
    
    class func nextTodoItemId() -> Int {
        return 0
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
