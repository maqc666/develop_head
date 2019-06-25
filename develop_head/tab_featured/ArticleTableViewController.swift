//
//  ArticleTableViewController.swift
//  develop_head
//
//  Created by zhj on 2019/6/5.
//  Copyright © 2019年 zhj. All rights reserved.
//

import UIKit

class ArticleTableViewController: BaseArticleTableViewController {

    var bannerView:BannerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.bannerView = BannerView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: FIT_HEIGHT(210)), withVM: BannerViewModel())

        self.tableView.tableHeaderView = self.bannerView!
        loadBanner()
        
    }
    
}


extension ArticleTableViewController{

    func loadBanner()  {
        ApiProvider.request(.banner, model:[BannerModel].self) { (result) in
            self.bannerView?.bannerViewModel?.models = result
            self.bannerView?.reload()
        }
    }
    
}

