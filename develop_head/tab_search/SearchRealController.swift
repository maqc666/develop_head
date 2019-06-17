//
//  SearchRealController.swift
//  develop_head
//
//  Created by zhj on 2019/6/13.
//  Copyright © 2019年 zhj. All rights reserved.
//


import UIKit
import SnapKit

class SearchRealController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.navigationBar.isHidden = true
        uiConfig()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SearchRealController{
    func uiConfig() {
        
        let button = UIButton.init(type: UIButton.ButtonType.system)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setTitle("取消", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(goBack), for: UIControl.Event.touchUpInside)
        
        let titleView = SearchBarView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
        
        self.navigationItem.titleView = titleView
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView:button)

        let search = UISearchBar()
        search.placeholder = "输入独家号名称或者ID"
        search.delegate = self
        titleView.addSubview(search)
        
        search.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(10)
            make.height.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }

        
    }
}

extension SearchRealController{
    @objc func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchRealController:UISearchBarDelegate{
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar){
//        print("get text",searchBar.text)
    }
}
