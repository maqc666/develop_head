//
//  WebHeadView.swift
//  develop_head
//
//  Created by zhj on 2019/6/25.
//  Copyright © 2019年 zhj. All rights reserved.
//


import UIKit
import SnapKit

class WebHeadView:UIView{
    
    private lazy var title = genLabel()
    private lazy var read = genLabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        
        self.addSubview(title)
        title.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(5)
            make.width.greaterThanOrEqualTo(50)
            make.height.equalTo(20)
            make.leading.equalToSuperview().offset(20)
        })
        
        let img = UIView.init()
//        img.backgroundColor = UIColor.blue
        img.layer.cornerRadius = 1
        self.addSubview(img)
        img.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.width.greaterThanOrEqualTo(50)
            make.height.equalTo(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        
        read.textAlignment = NSTextAlignment.right
        self.addSubview(read)
        read.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(15)
            make.width.greaterThanOrEqualTo(50)
            make.height.equalTo(20)
            make.trailing.equalToSuperview().offset(20)
        })
    }
    
    public func setTitle(_ t:String,read r:String ){
        title.text = t;
        read.text = "阅读:"+r
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

