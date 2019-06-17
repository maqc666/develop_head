//
//  BaseArticleTableViewController.swift
//  develop_head
//
//  Created by zhj on 2019/6/10.
//  Copyright © 2019年 zhj. All rights reserved.
//

import UIKit
import MJRefresh

class BaseArticleTableViewController: UITableViewController {
    
    var articleViewModel:ArticleViewModel?
    
    
    let header = MJRefreshNormalHeader()
    let footer = MJRefreshAutoNormalFooter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleViewModel = ArticleViewModel()

        self.tableView?.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        
        
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        self.tableView.mj_header = header
        
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerLoad))
        self.tableView.mj_footer = footer
        self.tableView.tableFooterView = UIView()
        header.beginRefreshing()
        
        
        
        self.articleViewModel?.callback = { [weak self] (lastet) in
            if lastet {
                self?.header.endRefreshing()
            }else{
                self?.footer.endRefreshing()
            }
            self?.tableView.reloadData()
        }
        
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let am = articleViewModel?.articleModel else{
            return 0
        }
        return am.article!.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("click,",indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ArticleReadViewController()
        vc.articleViewModel = articleViewModel
        vc.current = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell")
            as! ArticleTableViewCell
        guard let am = articleViewModel?.articleModel else{
            return cell
        }
        cell.fill(am.article![indexPath.row])
        return cell
    }
}
//MARK: refresh
extension BaseArticleTableViewController{
    
    @objc func footerLoad(){
        self.articleViewModel?.requestPreDate()
    }
    
    @objc func headerRefresh()  {
        self.articleViewModel?.requestLatest()
    }
}
