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

        print("Hello swift")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //设置tableView的行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //返回10条数据
        return 10
    }
    
    //设置cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //为cell设置Identifier
        let cellIdentifier = "typeCell"
        
        //依据Identifer创建Cell
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier )
        
        //设置cell的标题
        cell.textLabel?.text = "任务分类:\(indexPath.row)"
        
        //设置cell的缩略图
        cell.imageView?.image = UIImage(named: "心情")
        
        return cell
    }
}
