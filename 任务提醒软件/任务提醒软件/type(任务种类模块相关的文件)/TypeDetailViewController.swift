//
//  TypeDetailViewController.swift
//  任务提醒软件
//
//  Created by WongHoyu on 2018/5/10.
//  Copyright © 2018年 hwanghaoyu. All rights reserved.
//

import UIKit

class TypeDetailViewController: UITableViewController {
    //定义一个TypeItem类型的属性
    var typeItem:TypeItem = TypeItem(name: "")
    
    //设置状态，是添加分类还是编辑分类
    var isAdd:Bool = true
    
    //是否加载过
    var isLoad:Bool = false
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("1")
        isLoad = true
    }
    
    @IBAction func done(_ sender: Any) {
        //获取分类名称
        typeItem.name = textField.text!
        
        if isAdd {
            //将新的分类加进分类数组
            todoModel.onAddType(type: typeItem)
        }
        
        //获取任务分类视图的导航控制器
        let navigation = self.tabBarController?.viewControllers![0] as! UINavigationController
        
        //获取任务分类视图
        let typeView = navigation.viewControllers.first as! TypeViewController
        
        //更新任务分类视图的数据
        typeView.tableView.reloadData()
        
        //界面跳转
        self.tabBarController?.selectedIndex = 0
        
        //还原成添加状态
        onAddType()
    }
    
    /// 添加分类方法
    func onAddType() {
        //将标示设为添加任务分类状态
        isAdd = true
        
        //将typeItem设为新的空数据
        typeItem = TypeItem(name: "")
        
        //设置视图标题
        self.title = "添加"
        
        //执行更新方法
        onUpdate()
    }
    
    /// 编辑分类方法
    ///
    /// - Parameter item: 目标分类
    func onEditType(item:TypeItem) {
        
        //将标示设为编辑任务分类状态
        isAdd = false
        
        //设置标题
        self.title = "编辑分类"
        
        //接收传过来的分类数据
        self.typeItem = item
        print("3")
        //如果视图没有被加载过则放入viewDidLoad进行执行
        if isLoad {
            print("2")
            onUpdate()
        }
        
    }
    
    /// 跟新界面方法
    func onUpdate() {
        self.textField.text = self.typeItem.name
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    

}
