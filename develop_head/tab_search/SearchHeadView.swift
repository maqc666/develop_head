//
//  SearchHeadView.swift
//  develop_head
//
//  Created by zhj on 2019/6/13.
//  Copyright © 2019年 zhj. All rights reserved.
//

import UIKit

import SnapKit


class SearchHeadView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        uiConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchHeadView{
    
    @objc func click(button:UIButton){
//        print("button",button.tag)
        
        switch button.tag {
        case 100:print("0")
        case 101:print("1")
        case 102:print("2")
        case 103:print("3")
        default:
            print("default")
        }
    }
    func uiConfig(){
        
        let titles = ["热门文章","热门独家号","活动","文章标签"]
        
        let images = ["btn_hot_articles","btn_hot_subjects","btn_hot_events","btn_hot_tags"]
    
        for index in 0..<images.count {
            
            let button = UIButton.init(type: UIButton.ButtonType.custom)
            button.setImage(UIImage(named: images[index]), for: UIControl.State.normal)
            button.tag = 100+index
            button.addTarget(self, action: #selector(click(button:)), for: UIControl.Event.touchUpInside)
            self.addSubview(button)
            
            button.snp.makeConstraints { (make) in
                make.width.equalTo(45)
                make.height.equalTo(45)
                make.centerY.equalTo(self).offset(-5)
                make.leading.equalTo(self).offset(40+100*index)
            }
            
            let label = UILabel()
            label.text = titles[index]
            label.textAlignment = NSTextAlignment.center
            label.font = .systemFont(ofSize: 16)
            label.numberOfLines = 0
            button.addSubview(label)
            
            label.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(button.snp.bottom)
                make.width.equalTo(100)
                make.height.equalTo(20)
                
            }
        }
    }
}
