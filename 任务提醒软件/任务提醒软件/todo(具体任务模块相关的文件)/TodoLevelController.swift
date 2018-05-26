//
//  TodoLevelController.swift
//  任务提醒软件
//
//  Created by WongHoyu on 2018/5/24.
//  Copyright © 2018年 hwanghaoyu. All rights reserved.
//

import UIKit

class TodoLevelController: UITableViewController {
    //数据源
    var arrLevel:[LevelItem] = [LevelItem]()
    
    //代理
    var delegate:ProtocolLevel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择任务的重要程度"
    }

    /// 创建数据并设置选择的项
    ///
    /// - Parameter level: 重要程度
    func onSetCheckMark(level:Int) {
        for i in 0...4 {
            let item = LevelItem(level: i)
            if i == level {
                item.checkMark = true
            }
            arrLevel.append(item)
        }
    }
    
    //设置table的行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLevel.count
    }

    //设置table的单元格
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //获取cell对应的数据
        let item = arrLevel[indexPath.row]
        
        //获取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "levelCell", for: indexPath)
        cell.textLabel!.text = item.title
        if item.checkMark {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    //选择单元格
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = arrLevel[indexPath.row]
        delegate?.onGetLevel(levelItem: item)
    }
    
}

protocol ProtocolLevel {
    func onGetLevel(levelItem:LevelItem)
}
