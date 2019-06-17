//
//  FeaturedViewController.swift
//  develop_head
//
//  Created by zhj on 2019/6/3.
//  Copyright © 2019年 zhj. All rights reserved.
//

import UIKit
import SGPagingView
import SnapKit


class FeaturedViewController: UIViewController {
    private var articleViewModel:ArticleViewModel?
    private var allControllers:[BaseArticleTableViewController]?
    private var pageTitleView:SGPageTitleView?;
    private var pageContentScrollView:SGPageContentScrollView?;
    
//    private lazy var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white;

        loadTitle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
// MARK:data
extension FeaturedViewController{
    func loadTitle() {
//        let group = DispatchGroup()
        ApiProvider.request(.tab_post_nodes, model: [TabPostNode].self) {
            self.setupTitle($0!)
        }
    }
}

// MARK:ui
extension FeaturedViewController:SGPageTitleViewDelegate,SGPageContentScrollViewDelegate{
    func pageTitleView(_ pageTitleView: SGPageTitleView!, selectedIndex: Int) {
        self.pageContentScrollView?.setPageContentScrollViewCurrentIndex(selectedIndex)
    }
    
    func pageContentScrollView(_ pageContentScrollView: SGPageContentScrollView!, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        
        self.pageTitleView?.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
    
    func setupTitle(_ arr: [TabPostNode]){
        
        var titles = ["精选"]
        
        allControllers = [BaseArticleTableViewController]()
        allControllers!.append(ArticleTableViewController())
        
        for item in arr {
            titles.append(item.name!)
            let tab = ArticleNodeTableViewController()
            tab.node = item.id!
            allControllers!.append(tab)
        }
        
        pageTitleView = SGPageTitleView.init(frame: CGRect(x: 0, y: TITLE_BAR_HEIGHT, width: SCREEN_WIDTH, height: TITLE_BAR_HEIGHT), delegate: self, titleNames:titles, configure: SGPageTitleViewConfigure.init())
        view.addSubview(pageTitleView!)
    
        
        self.pageContentScrollView = SGPageContentScrollView(frame: CGRect(x: 0, y: 2*TITLE_BAR_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-2*TITLE_BAR_HEIGHT-TAB_BAR_HEIGHT), parentVC: self, childVCs:allControllers!)
        
        self.pageContentScrollView!.delegatePageContentScrollView = self
        self.view.addSubview(self.pageContentScrollView!)
    }
}
