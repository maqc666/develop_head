//
//  BannerViewModel.swift
//  develop_head
//
//  Created by zhj on 2019/6/6.
//  Copyright © 2019年 zhj. All rights reserved.
//

import UIKit

class BannerViewModel{
//    func count() -> Int {
//        return 4
//    }
    var count: Int{
        return models?.count ?? 0
    }
    var models:[BannerModel]?
}
