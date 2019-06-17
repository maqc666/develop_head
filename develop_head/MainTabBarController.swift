//
//  MainTableViewController.swift
//  develop_head
//
//  Created by zhj on 2019/6/3.
//  Copyright © 2019年 zhj. All rights reserved.
//

import UIKit

class MainTabBarController:UITabBarController {

    lazy var bgImageView: UIView = {
        let img   = UIView()
        img.frame = CGRect(x: 0, y: SCREEN_HEIGHT - TAB_BAR_HEIGHT, width: SCREEN_WIDTH, height: TAB_BAR_HEIGHT)
        img.isUserInteractionEnabled = true
        img.backgroundColor = UIColor.clear
        return img
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        delegate = self
        
        addChildViewController(FeaturedViewController(),title:"阅读",imageName:"tab_icon_featured")
        addChildViewController(MessageViewController(),title:"消息",imageName:"tab_icon_message")

    addChildViewController(PublishViewController(),title:"",imageName:"")
        
        addChildViewController(SearchViewController(),title:"发现",imageName:"tab_icon_search")
        addChildViewController(AccountViewController(),title:"我的",imageName:"tab_icon_account")
    
        
        
        
        

        
        addButton()
    
    }
    
//    @objc private func click(button:UIButton){
//        print("click")
//    }
    
    
    func addChildViewController(_ childController: UIViewController,title:String, imageName:String ) {
        childController.title = title
        childController.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage:UIImage(named: imageName+"_selected"))
        addChild(MyNavigationController(rootViewController:childController))
    }
}

extension MainTabBarController:UITabBarControllerDelegate{
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
        
        print("didi select at",viewController)
    }
    
    
    func addButton() {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.bounds = CGRect(x:0,y:0,width:50,height:50);

        button.center = CGPoint(x:self.tabBar.frame.size.width/2, y:self.tabBar.frame.size.height/2);
//        button.addTarget(self, action: #selector(click(button:)), for: UIControl.Event.touchUpInside)
        
        button.setImage(UIImage(named: "tabbar_compose_button"), for: UIControl.State.normal)
        button.setImage(UIImage(named: "tabbar_compose_button_selected"), for: UIControl.State.selected)
        tabBar.addSubview(button)
    }

}
