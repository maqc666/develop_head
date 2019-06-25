//
//  BaseArticleTableViewController.swift
//  develop_head
//
//  Created by zhj on 2019/6/10.
//  Copyright © 2019年 zhj. All rights reserved.
//

import UIKit
import MJRefresh
import RxSwift
import RxCocoa
import RxDataSources

class BaseArticleTableViewController: UIViewController {
    
    lazy var tableView:UITableView = {
        let tab = UITableView()
        tab.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        return tab
    }()
    var articleViewModel:ArticleViewModel?
    
    private let disposeBag = DisposeBag()
    let header = MJRefreshNormalHeader()
    let footer = MJRefreshAutoNormalFooter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        uiConfig()
        bindViewModel()
    }
    
}
//MARK: refresh
extension BaseArticleTableViewController{
    
    @objc func footerLoad(){
        self.articleViewModel?.requestPreDate()
    }
    
    @objc func headerRefresh()  {
        self.articleViewModel?.requestLatest()
    }
}

extension BaseArticleTableViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func uiConfig(){
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
        }
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        tableView.mj_header = header
        
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerLoad))
        tableView.mj_footer = footer
        tableView.tableFooterView = UIView()
        header.beginRefreshing()
    }
}

extension BaseArticleTableViewController{
    func bindViewModel() {
        articleViewModel = ArticleViewModel()
        //创建数据源
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,Article>>(
            //设置单元格
            configureCell: { ds, tv, indexPath, item in
                let cell = tv.dequeueReusableCell(withIdentifier: "ArticleTableViewCell")
                    as! ArticleTableViewCell
                cell.fill(item)
                return cell
        }
        )
        
        articleViewModel!.reload.asObservable().subscribe(onNext:{
            [weak self] in
            if($0){
                self?.header.endRefreshing()
            }else{
                self?.footer.endRefreshing()
            }
        }).disposed(by: disposeBag)
        
        //绑定单元格数据
        articleViewModel!.data
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(Article.self))
            .bind { [weak self] indexPath, item in
                // 取消选中，这句代码执行后不会触发 tableView.rx.itemDeselected和tableView.rx.modelDeselected
                self?.tableView.deselectRow(at: indexPath, animated: false)
                
//                print("选中项的indexPath为：\(indexPath)")
//                print("选中项的标题为：\(item)")
                
                let vc = ArticleReadViewController()
                vc.articleViewModel = self?.articleViewModel
                vc.current = indexPath.row
                self?.navigationController?.pushViewController(vc, animated: true)

                
                
            }
            .disposed(by: disposeBag)
    }
}
