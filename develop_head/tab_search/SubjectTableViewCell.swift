//
//  SubjectTableViewCell.swift
//  develop_head
//
//  Created by zhj on 2019/6/13.
//  Copyright © 2019年 zhj. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class SubjectTableViewCell : UITableViewCell{
    
    
    private lazy var icon:UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    private lazy var title:UILabel = genLabel(size: 18,color: UIColor.rgba(0,0,0))
    
    private lazy var desc:UILabel = genLabel(size: 16)
    
    private lazy var share:UILabel = genLabel(size: 16)
    
    private lazy var subscriber:UILabel = genLabel(size: 16)
    
    private lazy var rightButton:UIButton = {
        let button = UIButton.init(type:UIButton.ButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "cell_btn_subscribe"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(click(button:)), for:UIControl.Event.touchUpInside)
        return button
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        uiConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension SubjectTableViewCell{
    
    func fill(_ info:SubjectsInfo ){
        title.text = info.name!
        desc.text = info.descriptionField!
        share.text = info.postCount!.description+" 分享"
        subscriber.text = info.subscriberCount!.description+" 订阅者"
        guard let img = info.image else{
            return
        }
        self.icon.kf.setImage(with: URL(string: img))
    }

    func uiConfig() {
        self.contentView.addSubview(icon)
        self.contentView.addSubview(title)
        self.contentView.addSubview(desc)
        self.contentView.addSubview(share)
        self.contentView.addSubview(subscriber)
        self.contentView.addSubview(rightButton)
        
        let top = 20
        icon.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.top.equalToSuperview().offset(top)
            make.leading.equalToSuperview().offset(20)
        }
        
        title.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(top)
            make.width.greaterThanOrEqualTo(50)
            make.height.equalTo(25)
            make.leading.equalTo(icon.snp.trailing).offset(20)
        }
//
        desc.snp.makeConstraints { (make) in
            make.top.equalTo(title).offset(20)
            make.height.equalTo(25)
            make.width.greaterThanOrEqualTo(50)
            make.width.lessThanOrEqualTo(190)
            make.leading.equalTo(icon.snp.trailing).offset(20)
        }
//
        share.snp.makeConstraints { (make) in
            make.top.equalTo(desc).offset(20)
            make.height.equalTo(25)
            make.width.greaterThanOrEqualTo(50)
            make.leading.equalTo(icon.snp.trailing).offset(20)
        }

        subscriber.snp.makeConstraints { (make) in
            make.top.equalTo(desc).offset(20)
            make.height.equalTo(25)
            make.width.greaterThanOrEqualTo(50)
            make.leading.equalTo(share.snp.trailing).offset(10)
        }
        
        rightButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
            make.width.equalTo(30)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    
    @objc func click(button:UIButton){
        print("click")
    }
}
