//
//  TodoListController.swift
//  任务提醒软件
//
//  Created by WongHoyu on 2018/5/15.
//  Copyright © 2018年 hwanghaoyu. All rights reserved.
//

import UIKit

class TodoListController: UITableViewController, ProtocolTodoDetail {

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
        label.text = item!.text + "\(LevelItem.onGetTitle(level: item!.level))"
        
        //设置cell的勾选状态
        onCheckMark(cell: cell, item: item!)
        
        return cell
    }
    
    //滑动删除
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        //删除数据
        todoList?.items.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        
        //保存数据
        todoModel.saveData()
        
        //通知视图删除的数据，同时显示删除动画
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    //改变滑动删除显示的删除文字
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
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
        
        //保存数据
        todoModel.saveData()
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
    
    //界面跳转时，设置数据
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //通过segue的标识获得导航控制器
        let navigationController = segue.destination as! UINavigationController
        
        //通过导航控制器的topViewController属性获得跳转目标
        let controller = navigationController.topViewController as! TodoDetailController
        
        //设置代理
        controller.delegate = self
        let segueStr = "\(segue.identifier!)"
        if segueStr == "AddItem" {
            //设置状态为添加任务
            controller.isAdd = true
        } else if segueStr == "EditItem" {
            //获取indexPath
            let indexPath = self.tableView.indexPath(for: sender! as! UITableViewCell)
            
            //将要编辑的Model传给新界面
            controller.todoItem = todoList!.items[indexPath!.row]
            controller.isAdd = false
        }
    }
    
    /// 增加任务
    ///
    /// - Parameter item: todoItem
    func addItem(item: TodoItem) {
        todoList?.items.append(item)
        self.tableView.reloadData()
    }
    
    /// 修改任务
    func editItem() {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
