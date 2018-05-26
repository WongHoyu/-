//
//  TypeViewController.swift
//  任务提醒软件
//
//  Created by WongHoyu on 2018/5/10.
//  Copyright © 2018年 hwanghaoyu. All rights reserved.
//

import UIKit

class TypeViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //重新加载数据
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //设置tableView的行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //返回数据条数
        return todoModel.typeList.count
    }
    
    //设置cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //获取行对应的数据
        let typeItem = todoModel.typeList[indexPath.row]
        
        //为cell设置Identifier
        let cellIdentifier = "typeCell"
        
        //依据Identifer创建Cell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        
        //设置cell的标题
        cell.textLabel?.text = typeItem.name
        
        //设置cell的缩略图
        cell.imageView?.image = UIImage(named: typeItem.icon)
        
        //返回有多少个任务代办需要提醒
        let count = typeItem.countUncheckedItems()
        
        //根据不同的情况显示不同的副标题
        if typeItem.items.count == 0 {
            //如果还没有添加任务
            cell.detailTextLabel?.text = "还没有添加任务"
        } else {
            if count == 0 {
                cell.detailTextLabel?.text = "全部搞定"
            } else {
                cell.detailTextLabel?.text = "还有 \(count) 个任务要完成"
            }
        }
        
        return cell
    }
    
    //点击cell，跳转到编辑页面
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //获取选中行的数据
        let type = todoModel.typeList[indexPath.row]
        
        //可以将任何东西放入sender，对应prepareForSegue中的sender
        self.performSegue(withIdentifier: "showTodoList", sender: type)
    }
    
    //segue切换，传参
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //获取跳转目标
        let controller = segue.destination as! TodoListController
        
        //给目标传参
        controller.todoList = sender as? TypeItem
    }
    
    //原滑动删除
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }

    
    //滑动删除与编辑
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .default, title: "编辑") {
            (action:UITableViewRowAction, indexPath:IndexPath) -> Void in
            //获取选中的数据
            let typeItem = todoModel.typeList[indexPath.row]
            
            //获取添加视图的导航控制器
            let navigation = self.tabBarController?.viewControllers![1] as! UINavigationController
         
            //获取"添加"视图
            let typeDetail = navigation.viewControllers.first as! TypeDetailViewController
            typeDetail.onEditType(item: typeItem)
            
            //视图跳转
            self.tabBarController?.selectedIndex = 1
            
        }
        let deleteAction = UITableViewRowAction(style: .normal, title: "删除") {
            (action:UITableViewRowAction, indexPath:IndexPath) -> Void in
            
            //删除数据
            todoModel.typeList.remove(at: indexPath.row)
            
            //删除数据的位置标识数组
            let indexPaths = [indexPath]
            
            //通知视图删除的数据，同时显示删除动画
            tableView.deleteRows(at: indexPaths, with: .automatic)
        }
        
        //设置背景颜色
        //亮灰色
        editAction.backgroundColor = UIColor.lightGray
        //红色
        deleteAction.backgroundColor = UIColor.red
        
        //保存数据
        todoModel.saveData()
        return [deleteAction, editAction]
    }
    
    
}
