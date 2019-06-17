//
//  ArticleReadViewController.swift
//  develop_head
//
//  Created by zhj on 2019/6/17.
//  Copyright © 2019年 zhj. All rights reserved.
//

import UIKit
import WebKit

class ArticleReadViewController:MyViewController{
    var current:Int = 0
    var articleViewModel:ArticleViewModel?
    
    lazy var webView: WKWebView = {
        let web = WKWebView.init(frame: self.view.frame)
        web.navigationDelegate = self
        web.uiDelegate = self
        return web
    }()
    
    
    lazy var leftButton:UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named:"btn_icon_navi_back"), for: UIControl.State.normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(goBack(button:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    lazy var rightButton:UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named:"btn_icon_navi_share"), for: UIControl.State.normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(self, action: #selector(goBack(button:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiConfig()
        loadContent()
    }
}

extension ArticleReadViewController{
    func uiConfig(){
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightButton)
        self.view.addSubview(webView)
    }
    
    func loadContent() {
        let article = articleViewModel!.articleModel!.article!
        self.title = article[current].title
        let url = URL.init(string:article[current].originalUrl!)!
        webView.load(URLRequest.init(url:url))
    }
}

extension ArticleReadViewController:WKNavigationDelegate,WKUIDelegate{
    //MARK:- 页面开始加载时候调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("页面开始加载")
    }
    
    //MARK:- 当内容开始返回的时候调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("开始返回内容")
    }
    
    //MARK:- 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("页面加载完成")
    }
    
    //MARK:- 页面加载失败的时候调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("页面加载失败")
    }
}
