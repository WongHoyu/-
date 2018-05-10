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
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func done(_ sender: Any) {
        //获取分类名称
        typeItem.name = textField.text!
        
        //将新的分类加紧分类数组
        todoModel.onAddType(type: typeItem)
        
        //界面跳转
        self.tabBarController?.selectedIndex = 0
        
        print("新增分类，名称：\(typeItem.name), 图标：\(typeItem.icon)")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    

}
