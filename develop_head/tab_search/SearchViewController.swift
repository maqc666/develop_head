//
//  SearchViewController.swift
//  develop_head
//
//  Created by zhj on 2019/6/3.
//  Copyright © 2019年 zhj. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh

class SearchViewController: UITableViewController {
    private var searchViewModel:SearchViewModel?
    private let header = MJRefreshNormalHeader()
    
    
    private let headViewTitleArr = [
        ["编辑推荐","查看更多"],
        ["活跃团队号","查看热门"],
        ["活跃独家号","查看最新"],
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        searchViewModel = SearchViewModel()
        uiConfig()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SearchViewController{
    func uiConfig() {
        let parent = self.navigationController!.navigationBar
        parent.barTintColor = UIColor.rgba(45,171,250)
        
        let titleView = SearchBarView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44))
//        titleView.backgroundColor = UIColor.black
        self.navigationItem.titleView = titleView
//        self.navigationItem.rightBarButtonItem = nil
    
        
        let search = UISearchBar()
        search.placeholder = "搜索感兴趣的文章"
        search.delegate = self
        titleView.addSubview(search)
//
        search.snp.makeConstraints { (make) in
            make.width.equalToSuperview().inset(10)
            make.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        self.tableView.tableHeaderView = SearchHeadView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 80))
        self.tableView.register(SubjectTableViewCell.self, forCellReuseIdentifier: "reusecell")
        
        
        self.searchViewModel?.callback = { [weak self] _ in
            self?.tableView.reloadData()
            self?.header.endRefreshing()
        }
        
        
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        self.tableView.mj_header = header
        self.tableView.tableFooterView = UIView()
        header.beginRefreshing()
    
    }
}
//
extension SearchViewController:UISearchBarDelegate{
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool{
        self.navigationController?.pushViewController(SearchRealController(), animated: true)
        
        print("on click")
        return false
    }
    
}

extension SearchViewController{
    @objc func headerRefresh()  {
        self.searchViewModel?.request()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.searchViewModel?.recommend?.count ?? 0
        case 1:
            return self.searchViewModel?.team?.count ?? 0
        case 2:
            return self.searchViewModel?.random?.count ?? 0
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click,",indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusecell") as! SubjectTableViewCell
        
        var sb:SubjectsInfo? = nil
        switch indexPath.section {
        case 0:
            sb = self.searchViewModel?.recommend![indexPath.row]
        case 1:
            sb = self.searchViewModel?.team![indexPath.row]
        case 2:
            sb = self.searchViewModel?.random![indexPath.row]
        default:
            return cell
        }
        cell.fill(sb!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0 {
//            return 44
//        }
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = FOOT_VIEW_COLOR
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = NSTextAlignment.left
        label.numberOfLines = 1
        label.text = headViewTitleArr[section][0]
        view.addSubview(label)
        
        let button = UIButton.init(type: UIButton.ButtonType.system)
        button.setTitle(headViewTitleArr[section][1], for: UIControl.State.normal)
        view.addSubview(button)
        
        label.snp.makeConstraints { (make) in
            make.height.equalTo(20)
            make.width.greaterThanOrEqualTo(50)
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        button.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.width.equalTo(70)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
        }
        
        return view
    }
}
