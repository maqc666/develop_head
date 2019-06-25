//
//  BannerView.swift
//  develop_head
//
//  Created by zhj on 2019/6/6.
//  Copyright © 2019年 zhj. All rights reserved.
//

import UIKit
import FSPagerView
import SnapKit
import Kingfisher

class BannerView: UIView, NibLoadable {

    var bannerViewModel:BannerViewModel?
    var pageControl: FSPageControl?
    var pagerView: FSPagerView?
    
    init(frame: CGRect, withVM vm:BannerViewModel) {
        super.init(frame:frame)
        bannerViewModel = vm
        uiConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BannerView{
    func uiConfig(){
        
        self.pagerView = FSPagerView.init(frame: self.frame)
    
        self.addSubview(self.pagerView!)
        self.pagerView?.delegate = self
        self.pagerView?.dataSource = self
        
        self.pagerView?.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "FSPagerViewCell")
        self.pagerView?.itemSize = FSPagerView.automaticSize
        self.pagerView?.isInfinite = true
//        self.pagerView?.snp.makeConstraints({ (make) in
//            make.width.equalToSuperview()
//            make.height.equalTo(210)
//        })
        
        self.pageControl = FSPageControl.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.pageControl?.numberOfPages = self.bannerViewModel!.count
        self.pageControl?.contentHorizontalAlignment = .center
//        self.pageControl?.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        self.addSubview(self.pageControl!)

        
        self.pageControl?.snp.makeConstraints({ (make) in
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(20)
        })
    }
}


extension BannerView:FSPagerViewDataSource,FSPagerViewDelegate{
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.bannerViewModel!.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "FSPagerViewCell", at: index)
        let model = self.bannerViewModel?.models?[index]
        cell.imageView?.kf.setImage(with: URL(string: model!.image!))
        cell.textLabel?.text = model?.title!
        cell.textLabel?.numberOfLines = 0
//        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.clipsToBounds = true
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl?.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl?.currentPage = pagerView.currentIndex
    }
}


extension BannerView{
    func reload(){
        self.pagerView?.reloadData()
        self.pageControl?.numberOfPages = self.bannerViewModel!.count
    }
}
