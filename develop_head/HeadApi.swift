//
//  HeadApi.swift
//  devhead
//
//  Created by junlongnew on 2019/6/5.
//  Copyright © 2019 junlongnew. All rights reserved.
//


import Moya
import HandyJSON

enum HeadApi{
    case banner
    case tab_post_nodes//这个应该是顶部分类
    case articles(_ id:Int)
    case dailies(_ date:String)
    case by_node(_ node:Int, page:Int)
    
    case subjects(_ f:String) //发现页面编辑推荐 和随机推荐
    case team_subjects(_ f:String) //独家号
    case subjects_search(page:Int, q:String)//查询独家号
    case articles_search(page:Int, q:String)//文章查询
    case tags_search(page:Int, q:String)//标签查询
}


extension HeadApi:TargetType {
    var baseURL: URL {
        return URL(string: "https://api.toutiao.io")!
    }
    
    var path: String {
        var p = ""
        switch self {
        case .banner:
            p = "banner"
        case .tab_post_nodes:
            p = "tab_post_nodes"
        case let .dailies(date):
            p = "dailies/"+date
        case let .articles(id):
            p = "articles/"+id.description
        case .by_node:
            p = "articles/by_node"
        case .subjects:
            p = "subjects"
        case .team_subjects:
            p = "team_subjects"
        case .subjects_search:
            p = "subjects/search"
        case .articles_search:
            p = "articles/search"
        case .tags_search:
            p = "tags/search"
        }
        return "/v2/"+p
    }
    
    var method: Moya.Method {
        return .get
    }

    var task: Task {
        var parmeters: [String : Any] = [:]
        let stamp = Int(Date().timeIntervalSince1970).description
        parmeters["app_key"] = APP_KEY
        parmeters["timestamp"] = stamp
        parmeters["signature"] = self.genSignature(self.path,stamp:stamp)
        
        switch self {
        case let .by_node(node,page):
            parmeters["nid"] = node
            parmeters["page"] = page
            parmeters["page_size"] = 20
        case let .subjects(f):
            parmeters["f"] = f
        case let .team_subjects(f):
            parmeters["f"] = f
        case let .subjects_search(page,q):
            parmeters["page"] = page
            parmeters["page_size"] = 20
            parmeters["q"] = q
        case let .articles_search(page,q):
            parmeters["page"] = page
            parmeters["page_size"] = 20
            parmeters["q"] = q
        case let .tags_search(page,q):
            parmeters["page"] = page
            parmeters["page_size"] = 20
            parmeters["q"] = q
        default:
            break
        }
        
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return nil }
}

extension HeadApi{
    func genSignature(_ path:String, stamp:String)->String{
        return (SHA_SALT+stamp+path).sha1
    }
}


let ApiProvider = MoyaProvider<HeadApi>()

extension MoyaProvider {
    @discardableResult
    open func request<T>(_ target: Target,
                                    model: T.Type,
                                    completion: @escaping ((_ returnData: T?) -> Void)) -> Cancellable? {
        
        return request(target, completion: { (result) in
            
            switch result{
                case let .success(response):
                    let json = String(data: response.data, encoding: .utf8)
                    let ret = BaseResponse<T>.deserialize(from:json)
                    completion(ret?.data)
                case let .failure(error):
                completion(nil)
            }
            
        })
    }
    
    
}
