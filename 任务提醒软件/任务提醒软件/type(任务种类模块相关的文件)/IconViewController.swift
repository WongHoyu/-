//
//  IconViewController.swift
//  任务提醒软件
//
//  Created by WongHoyu on 2018/5/11.
//  Copyright © 2018年 hwanghaoyu. All rights reserved.
//

import UIKit

class IconViewController: UITableViewController {
    //协议代理
    var delegate:ProtocolIconView?
    
    var icons = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择图标"
        //所有的图标名称
        icons.append("分享")
        icons.append("货运")
        icons.append("记录")
        icons.append("旅行")
        icons.append("提醒")
        icons.append("天气")
        icons.append("卫生")
        icons.append("文件")
        icons.append("心情")
    }
    
    //返回数据行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    //设置cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //获取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "iconCell", for: indexPath)
        
        //获取图标名称
        let icon = icons[indexPath.row]
        
        //设置标题为图标名称
        cell.textLabel?.text = icon
        
        //根据图标名称设置缩略图
        cell.imageView?.image = UIImage(named: icon)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //获取图标name
        let iconName = icons[indexPath.row]
        self.delegate?.iconPicker(didPickIcon: iconName)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

protocol ProtocolIconView {
    
    func iconPicker(didPickIcon iconName:String)
}
