//
//  TodoListController.swift
//  任务提醒软件
//
//  Created by WongHoyu on 2018/5/15.
//  Copyright © 2018年 hwanghaoyu. All rights reserved.
//

import UIKit

class TodoListController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置标题
        self.title = self.todoList?.name
    }

    //tableView的数据
    var todoList:TypeItem?
    
    //设置table的行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList!.items.count
    }
    
    //设置table的单元格
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //获取cell对应的数据
        let item = todoList?.items[indexPath.row]
        
        //获取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        
        //设置标题内容
        cell.textLabel?.text = item?.text
        
        return cell
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
