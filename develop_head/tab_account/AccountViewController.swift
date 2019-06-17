//
//  AccountViewController.swift
//  develop_head
//
//  Created by zhj on 2019/6/3.
//  Copyright © 2019年 zhj. All rights reserved.
//

import UIKit

class AccountViewController: MyViewController {
    private lazy var tableView:UITableView = {
       let tab = UITableView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        return tab
    }()
    var data = [
        ["我订阅的独家号"],
        ["我的IO币","昨日收益","礼物兑换"],
        ["我的收藏","最近浏览"],
        ["意见反馈","合作申请"],
        ["推荐App给好友"],
    ]
    
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type:UIButton.ButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "cell_icon_settings"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(rightClick(button:)), for:UIControl.Event.touchUpInside)
        return button
    }()
    
    @objc func rightClick(button:UIButton){
        print("click")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiConfig()
    }
}

extension AccountViewController{
    func uiConfig() {
        tableView.backgroundColor = FOOT_VIEW_COLOR
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: self.rightBarButton)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
}

extension AccountViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = FOOT_VIEW_COLOR
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = FOOT_VIEW_COLOR
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier:"tbcell")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "tbcell")
        }
    
        cell!.textLabel?.text = data[indexPath.section][indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
}
