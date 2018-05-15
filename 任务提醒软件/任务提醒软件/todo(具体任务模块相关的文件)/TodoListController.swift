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
        
        //获取label
        let label = cell.viewWithTag(1000) as! UILabel
        
        //设置label内容
        label.text = item?.text
        
        return cell
    }
    
    ///设置check勾选
    func onCheckMark(cell:UITableViewCell, item:TodoItem) {
        //根据Tag获取cell中的checkbox
        let check = cell.viewWithTag(1002) as! UIImageView
        
        //通过item中的checked属性来控制勾号是否显示
        if item.checked {
            check.image = UIImage(named: "checkbox-checked")
        } else {
            check.image = UIImage(named: "checkbox-normal")
        }
    }
    
    //点击cell的响应方法
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //获取row数据
        let item = todoList?.items[indexPath.row]
        
        //check属性取反
        item?.onChangeChecked()
        
        //设置cell的勾选框
        let cell = tableView.cellForRow(at: indexPath)
        onCheckMark(cell: cell!, item: item!)
        
        //取消选中状态
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
