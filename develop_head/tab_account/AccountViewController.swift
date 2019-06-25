//
//  AccountViewController.swift
//  develop_head
//
//  Created by zhj on 2019/6/3.
//  Copyright © 2019年 zhj. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources



class AccountViewController: MyViewController {
    private lazy var tableView:UITableView = {
        let tab = UITableView()
        tab.register(UITableViewCell.self, forCellReuseIdentifier: "tbcell")
        return tab
    }()
    private lazy var sections = {
        return Observable.just(
            [
                SectionModel(model: "my", items: ["我订阅的独家号"]),
                SectionModel(model: "money", items: ["我的IO币","昨日收益","礼物兑换"]),
                SectionModel(model: "collect", items: ["我的收藏","最近浏览"]),
                SectionModel(model: "feedback", items: ["意见反馈","合作申请"]),
                SectionModel(model: "share", items: ["推荐App给好友"])
            ]
        )
    }()

    let disposeBag = DisposeBag()
    
    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type:UIButton.ButtonType.custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(UIImage(named: "cell_icon_settings"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(rightClick(button:)), for:UIControl.Event.touchUpInside)
        return button
    }()
    
    @objc func rightClick(button:UIButton){
        print("click")
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiConfig()

    }
}

extension AccountViewController{
    func uiConfig() {
        tableView.backgroundColor = FOOT_VIEW_COLOR
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: self.rightBarButton)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        

        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,String>>(
            //设置单元格
            configureCell: { ds, tv, index, item in
                let cell = tv.dequeueReusableCell(withIdentifier: "tbcell")!
                cell.textLabel?.text = item
                return cell
            }
        )
        
        //绑定单元格数据
        sections
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        
        //获取索引
        tableView.rx
            .itemSelected
            .subscribe(onNext: {
                [weak self]
                indexPath in
//                print("选中项的indexPath为：\(indexPath)")
                self?.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self).subscribe(onNext: {[weak self] item in
//            print("选中项的标题为：\(item)")
        }).disposed(by: disposeBag)
    }
}

extension AccountViewController:UITableViewDelegate{

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = FOOT_VIEW_COLOR
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = FOOT_VIEW_COLOR
        return view
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
}

