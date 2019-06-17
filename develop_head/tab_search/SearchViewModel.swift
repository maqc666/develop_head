//
//  SearchViewModel.swift
//  develop_head
//
//  Created by zhj on 2019/6/13.
//  Copyright © 2019年 zhj. All rights reserved.
//

import Foundation
class SearchViewModel{
    var recommend:[SubjectsInfo]?
    var team:[SubjectsInfo]?
    var random:[SubjectsInfo]?
    
    var callback:Callback<Int>?
    
    func request() {
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        ApiProvider.request(.subjects("featured2"), model:[SubjectsInfo].self) {
//            print("featured2 done",$0?.count)
            self.recommend = $0
            group.leave()
        }
        ApiProvider.request(.subjects("random"), model:[SubjectsInfo].self) {
//            print("random done",$0?.count)
            self.random = $0
            group.leave()
        }
        ApiProvider.request(.team_subjects("latest"), model:[SubjectsInfo].self) {
//            print("team_subjects done",$0?.count)
            self.team = $0
            group.leave()
        }
        group.notify(queue: DispatchQueue.main) {
            print("load done")
            self.callback?(0)
        }
    }
}
