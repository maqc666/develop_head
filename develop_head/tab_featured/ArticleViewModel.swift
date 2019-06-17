//
//  ArticleViewModel.swift
//  develop_head
//
//  Created by zhj on 2019/6/14.
//  Copyright © 2019年 zhj. All rights reserved.
//

import Foundation
class ArticleViewModel{
    private var page:Int = 1
    
    
    var callback:Callback<Bool>?
    var articleModel:ArticleModel?
    func requestLatest() {
//        let group = DispatchGroup()
//        group.enter()
//        group.enter()
//        group.enter()
        
        ApiProvider.request(.dailies("latest"), model:ArticleModel.self) {
            self.articleModel = $0
            self.callback?(true)
        }
    }
    
    func requestPreDate() {
        ApiProvider.request(.dailies(articleModel!.preDate!), model:ArticleModel.self) {
            let old = self.articleModel!.article
            self.articleModel?.article = old! + $0!.article!
            self.callback?(false)
        }
    }
    
    func requestByNode(_ node:Int, more:Bool) {
        ApiProvider.request(.by_node(node,page:page), model:[Article].self) {
            self.page += 1
            if more{
                let old = self.articleModel!.article
                self.articleModel?.article = old! + $0!
                
            }else{
                self.articleModel = ArticleModel()
                self.articleModel?.article = $0
            }
            self.callback?(!more)
        }
    }
}
