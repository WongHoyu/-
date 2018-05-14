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
        cell.textLabel?.text = "任务:\(indexPath.row)"
        
        //设置cell的缩略图
        cell.imageView?.image = UIImage(named: typeItem.icon)
        
        return cell
    }
    
    //点击cell，跳转到编辑页面
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //原滑动删除
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }

    
    //滑动删除与编辑
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var editAction = UITableViewRowAction(style: .default, title: "编辑") {
            (action:UITableViewRowAction, indexPath:IndexPath) -> Void in
            //获取选中的数据
            var typeItem = todoModel.typeList[indexPath.row]
            
            //获取添加视图的导航控制器
            let navigation = self.tabBarController?.viewControllers![1] as! UINavigationController
         
            //获取"添加"视图
            let typeDetail = navigation.viewControllers.first as! TypeDetailViewController
            typeDetail.onEditType(item: typeItem)
            
            //视图跳转
            self.tabBarController?.selectedIndex = 1
            
        }
        var deleteAction = UITableViewRowAction(style: .normal, title: "删除") {
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
        
        return [deleteAction, editAction]
    }
}
