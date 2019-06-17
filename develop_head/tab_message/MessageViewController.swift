//
//  MessageViewController.swift
//  develop_head
//
//  Created by zhj on 2019/6/3.
//  Copyright © 2019年 zhj. All rights reserved.
//

import UIKit

class MessageViewController: MyViewController {
    
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type:UIButton.ButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "cell_icon_login"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(rightClick(button:)), for:UIControl.Event.touchUpInside)
        return button
    }()
    @objc func rightClick(button:UIButton){
        print("click")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: self.rightBarButton)
    }
}
