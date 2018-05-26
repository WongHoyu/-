//
//  TypeDetailViewController.swift
//  任务提醒软件
//
//  Created by WongHoyu on 2018/5/10.
//  Copyright © 2018年 hwanghaoyu. All rights reserved.
//

import UIKit

class TypeDetailViewController: UITableViewController, UITextFieldDelegate, ProtocolIconView {
    //定义一个TypeItem类型的属性
    var typeItem:TypeItem = TypeItem(name: "")
    
    //设置状态，是添加分类还是编辑分类
    var isAdd:Bool = true
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置文本框的代理
        textField.delegate = self
    }
    
    //视图加载完毕之后执行
    override func viewWillAppear(_ animated: Bool) {
        onUpdate()
        textField.becomeFirstResponder()
        if isAdd {
            doneButton.isEnabled = false
        } else {
            doneButton.isEnabled = true
        }
    }
    
    //取消按钮
    @IBAction func cancel(_ sender: Any) {
        //界面跳转
        self.tabBarController?.selectedIndex = 0
        
        //还原成添加状态
        onAddType()
    }
    
    //确认按钮
    @IBAction func done(_ sender: Any) {
        //获取分类名称
        typeItem.name = textField.text!
        
        if isAdd {
            //将新的分类加进分类数组
            todoModel.onAddType(type: typeItem)
        } //else {
            //获取任务分类视图的导航控制器
            let navigation = self.tabBarController?.viewControllers![0] as! UINavigationController
            
            //获取任务分类视图
            let typeView = navigation.viewControllers.first as! TypeViewController
            
            //更新任务分类视图的数据
            typeView.tableView.reloadData()
            
        // }
        
        
        //界面跳转
        self.tabBarController?.selectedIndex = 0
        
        //还原成添加状态
        onAddType()
        
        //保存数据
        todoModel.saveData()
    }
    
    /// 添加分类方法
    func onAddType() {
        //将标示设为添加任务分类状态
        isAdd = true
        
        //将typeItem设为新的空数据
        typeItem = TypeItem(name: "")
        
        //设置视图标题
        self.title = "添加"
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
        
        
    }
    
    /// 跟新界面方法
    func onUpdate() {
        self.textField.text = self.typeItem.name
    }
    
    //检测界面切换
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //获取切换目标
        let controller = segue.destination as! IconViewController
        
        //设置代理
        controller.delegate = self
    }
    
    
    /// 设置图标
    ///
    /// - Parameter iconName: 图标名称
    func iconPicker(didPickIcon iconName: String) {
        typeItem.icon = iconName
        iconImageView.image = UIImage(named: iconName)
        //关闭选择图标界面
        self.navigationController?.popViewController(animated: true)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //获取到文本框内最新的文本
        let newText = textField.text!.replacingCharacters(in: range.toRange(string: textField.text!), with: string)
        
        //通过计算文本框内的字符数来决定done按钮是否激活
        doneButton.isEnabled = newText.count > 0
        return true
    }
    


}

extension NSRange {
    func toRange(string: String) -> Range<String.Index> {
        let startIndex = string.index(string.startIndex, offsetBy: self.location)
        let endIndex = string.index(startIndex, offsetBy: self.length)
        
        return startIndex..<endIndex
    }
}
