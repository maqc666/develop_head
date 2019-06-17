//
//  ArticleNodeTableViewController.swift
//  develop_head
//
//  Created by zhj on 2019/6/10.
//  Copyright © 2019年 zhj. All rights reserved.
//


import UIKit

class ArticleNodeTableViewController: BaseArticleTableViewController {
    
    
    var node:Int = 1
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        self.articleViewModel?.callback = {
//            [weak self] in
//            print("aa",$0)
//
//        }
//    }
    
    @objc override func footerLoad(){
        self.articleViewModel?.requestByNode(node,more: true)
    }
    
    @objc override func headerRefresh()  {
        self.articleViewModel?.requestByNode(node,more: false)
    }
}


