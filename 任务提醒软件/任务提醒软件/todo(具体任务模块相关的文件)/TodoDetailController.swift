//
//  TodoDetailController.swift
//  任务提醒软件
//
//  Created by WongHoyu on 2018/5/17.
//  Copyright © 2018年 hwanghaoyu. All rights reserved.
//

import UIKit

class TodoDetailController: UITableViewController {
    //添加还是编辑状态
    var isAdd:Bool = true
    //储存任务数据
    var todoItem = TodoItem()
    //代理
    var delegate:ProtocolTodoDetail?
    
    // MARK: - 控件属性
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var labLevel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isAdd {
            todoItem = TodoItem()
        } else {
            self.title = "编辑任务"
            textField.text = todoItem.text
            switchControl.isOn = todoItem.shouldRemind
        }
        upDateDueDateLabel()
        
    }
    
    //cancel按钮响应方法
    @IBAction func cancel(_ sender: Any) {
    }
    
    //Done按钮响应方法
    @IBAction func done(_ sender: Any) {
        todoItem.text = self.textField.text!
        todoItem.shouldRemind = self.switchControl.isOn
        if isAdd {
            //新增数据
            delegate?.addItem(item: todoItem)
        } else {
            //同时修改数据中的text为文本框编辑后的内容
            delegate?.editItem()
        }
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return super.tableView(tableView, numberOfRowsInSection: section)
    }
    
    //跟新显示时间的label
    func upDateDueDateLabel() {
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy年MM月DD日 HH:mm:ss"
        self.dueDateLabel.text = formatter.string(from: todoItem.dueDate)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//用于回调数据
protocol ProtocolTodoDetail {
    func addItem(item:TodoItem)
    func editItem()
}
