//
//  TodoDetailController.swift
//  任务提醒软件
//
//  Created by WongHoyu on 2018/5/17.
//  Copyright © 2018年 hwanghaoyu. All rights reserved.
//

import UIKit

class TodoDetailController: UITableViewController, ProtocolLevel {
    //添加还是编辑状态
    var isAdd:Bool = true
    //日期选择器是否隐藏
    var datePickerVisible:Bool = false
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
        
        labLevel.text = LevelItem
        .onGetTitle(level: todoItem.level)
        
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
    
    // MARK: - override
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 && datePickerVisible {
            return 4
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    //选择cell的row之后
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        textField.resignFirstResponder()
        //当执行到日期选择器上一行的时候，可以判断是否要显示日期选择器了
        if indexPath.section == 1 && indexPath.row == 2 {
            if !datePickerVisible {
                self.showDatePicker()
            } else {
                self.hideDatePicker()
            }
        }
    }
    
    //设置cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //因为日期选择器的位置在日期显示Label下面。他的位置就是第二个section和第4个row
        if indexPath.section == 1 && indexPath.row == 3 {
            //用重用的方法获取标识符为DatePickerCell的cell
            var cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerCell")
            
            //如果没找到就创建一个
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: "DatePickerCell")
                //设置cell的样式
                cell?.selectionStyle = .none
                //创建日期选择器
                let datePicker = UIDatePicker(frame: CGRect(x: 0.0, y: 0.0, width: 320.0, height: 216.0))
                //给日期选择器的tag
                datePicker.tag = 100
                //将日期选择日期加入cell
                cell?.contentView.addSubview(datePicker)
                datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
            }
            return cell!
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //当渲染到达日期选择器所在的cell的时候将cell的高度设为217
        if indexPath.section == 1 && indexPath.row == 3 {
            return 217.0
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        if indexPath.section == 1 && indexPath.row == 3 {
            //当执行到日期选择器所在的indexPath就创建一个indexPath然后强行插入
            let newIndexPath = IndexPath(row: 0, section: indexPath.section)
            return super.tableView(tableView, indentationLevelForRowAt: newIndexPath)
        } else {
            return super.tableView(tableView, indentationLevelForRowAt: indexPath)
        }
    }
    
    //连线跳转
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //获取跳转目标
        let controller = segue.destination as! TodoLevelController
        //设置代理
        controller.delegate = self
        //传参并生成数据
        controller.onSetCheckMark(level: self.todoItem.level)
    }
    
    
    //跟新显示时间的label4
    func upDateDueDateLabel() {
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "YYYY年 MM月 dd日 HH:mm:ss"
        dueDateLabel.text = formatter.string(from: todoItem.dueDate)
        print(todoItem.dueDate)
    }
    
    /// 显示日期选择器
    func showDatePicker() {
        //日期选择器的状态设为打开
        datePickerVisible = true
        
        let indexPathDatePicker = IndexPath(row: 3, section: 1)
        self.tableView.insertRows(at: [indexPathDatePicker], with: .automatic)
    }
    
    /// 隐藏日期选择器
    func hideDatePicker() {
        if datePickerVisible {
            // 日期选择器的状态设为关闭
            datePickerVisible = false
            let indexPathDatePicker = IndexPath(row: 3, section: 1)
            self.tableView.deleteRows(at: [indexPathDatePicker], with: .fade)
        }
    }
    
    @objc func dateChange(datePicker: UIDatePicker) {
        //改变dueDate
        todoItem.dueDate = datePicker.date
        //更新提醒时间文本框
        upDateDueDateLabel()
    }
    
    //实现ProtocolLevel协议索要的方法
    func onGetLevel(levelItem: LevelItem) {
        //更新重要级别的文本标签
        labLevel.text = levelItem.title
        //跟新todoItem中的级别
        todoItem.level = levelItem.level
        //关闭级别选择界面
        self.navigationController?.popViewController(animated: true)
    }
}

//用于回调数据
protocol ProtocolTodoDetail {
    func addItem(item:TodoItem)
    func editItem()
}
