//
//  MyViewController.swift
//  develop_head
//
//  Created by zhj on 2019/6/13.
//  Copyright © 2019年 zhj. All rights reserved.
//

import UIKit


class MyViewController:UIViewController{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.isHidden = false
        navigationBar?.barTintColor = UIColor.rgba(45,171,250)
        var textAttributes: [NSAttributedString.Key: AnyObject] = [:]
        textAttributes[.foregroundColor] = UIColor.white
        navigationBar?.titleTextAttributes = textAttributes
        view.backgroundColor = UIColor.white
    }
    
    @objc func goBack(button:UIButton){
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.popViewController(animated: true)
    }
}
