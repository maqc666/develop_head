//
//  TabPostNodeModel.swift
//  devhead
//
//  Created by junlongnew on 2019/6/5.
//  Copyright © 2019 junlongnew. All rights reserved.
//

import Foundation
import HandyJSON


struct BaseResponse<T>:HandyJSON {
    var data : T?
    var errcode : Int = -1
    var msg : String?
    var ret : Int = -1
}

struct BannerModelArticle:HandyJSON{
    var id : Int?
}
struct Page:HandyJSON{
    var route : String?
}
struct Webpage:HandyJSON{
    var url : String?
}

struct BannerModel:HandyJSON {
    var adId : Int?
    var article : BannerModelArticle?
    var contentType : String?
    var image : String?
    var page : Page?
    var title : String?
    var webpage : Webpage?
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.adId <-- "ad_id"
        mapper <<<
            self.article <-- "article"
        mapper <<<
            self.contentType <-- "content_type"
        mapper <<<
            self.image <-- "image"
        mapper <<<
            self.page <-- "page"
        mapper <<<
            self.title <-- "title"
        mapper <<<
            self.webpage <-- "webpage"
    }
    
}


struct TabPostNode:HandyJSON {
    var id : Int?
    var name : String?
    var slug : String?
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.id <-- "id"
        mapper <<<
            self.name <-- "name"
        mapper <<<
            self.slug <-- "slug"
    }
}

struct ArticleModel:HandyJSON{
    
    var article : [Article]?
    var date : String?
    var isToday : Bool?
    var nextDate : String?
    var preDate : String?
    var shareUrl : String?
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.isToday <-- "is_today"
        mapper <<<
            self.nextDate <-- "next_date"
        mapper <<<
            self.preDate <-- "pre_date"
        mapper <<<
            self.shareUrl <-- "share_url"
    }
}

struct Article:HandyJSON{
    
    var authorInfo : AuthorInfo?
    var commentCount : Int?
    var contributor : String?
    var createdAt : Int?
    var favoriteCount : Int?
    var favorited : Bool?
    var id : Int?
    var image : AnyObject?
    var isAdvertorial : Bool?
    var isBodyEmpty : Bool?
    var isFeatured : Bool?
    var isRecommend : Bool?
    var likeCount : Int?
    var liked : Bool?
    var originalSiteName : String?
    var originalUrl : String?
    var showOriginContent : Bool?
    var subject : Subject?
    var thumbnail : String?
    var title : String?
    var user : User?
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.authorInfo <-- "author_info"
        mapper <<<
            self.commentCount <-- "comment_count"
        mapper <<<
            self.createdAt <-- "created_at"
        mapper <<<
            self.favoriteCount <-- "favorite_count"
        mapper <<<
            self.isAdvertorial <-- "is_advertorial"
        mapper <<<
            self.isBodyEmpty <-- "is_body_empty"
        mapper <<<
            self.isFeatured <-- "is_featured"
        mapper <<<
            self.isRecommend <-- "is_recommend"
        mapper <<<
            self.likeCount <-- "like_count"
        mapper <<<
            self.originalSiteName <-- "original_site_name"
        mapper <<<
            self.originalUrl <-- "original_url"
        mapper <<<
            self.showOriginContent <-- "show_origin_content"
    }
}
struct User:HandyJSON{
    var avatar : String?
    var bio : String?
    var company : String?
    var followSkill : String?
    var following : Bool?
    var id : String?
    var name : String?
    var title : String?
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.followSkill <-- "follow_skill"
    }
}

struct Subject:HandyJSON{
    var id : Int?
    var image : String?
    var name : String?
    var type : String?
}
struct AuthorInfo:HandyJSON{
    var name : String?
    var url : String?
}




struct SubjectsInfo:HandyJSON{
    
    var createdAt : Int?
    var descriptionField : String?
    var id : Int?
    var image : String?
    var memberCount : Int?
    var name : String?
    var postCount : Int?
    var pushEnabled : Bool?
    var subscribed : Bool?
    var subscriberCount : Int?
    var type : String?
    var user : User?
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.createdAt <-- "created_at"
        mapper <<<
            self.descriptionField <-- "description"
        mapper <<<
            self.memberCount <-- "member_count"
        mapper <<<
            self.postCount <-- "post_count"
        mapper <<<
            self.pushEnabled <-- "push_enabled"
        mapper <<<
            self.subscriberCount <-- "subscriber_count"
    }
}


struct ArticleData:HandyJSON{
    
    var allowApply : Bool?
    var applyBtn : String?
    var author : String?
    var authorInfo : AuthorInfo?
    var body : String?
    var commentCount : Int?
    var commentDisabled : Bool?
    var contributor : String?
    var createdAt : Int?
    var css : [String]?
    var displayFullContent : Bool?
    var eventApplied : Bool?
    var eventBeginAt : Int?
    var eventEndAt : Int?
    var favoriteCount : Int?
    var id : Int?
    var image : AnyObject?
    var isFeatured : Bool?
    var isRecommend : Bool?
    var js : [String]?
    var jsImgNone : [String]?
    var likeCount : Int?
    var originalSiteName : String?
    var originalUrl : String?
    var shareImageUrl : String?
    var shareUrl : String?
    var showOriginContent : Bool?
    var subject : Subject?
    var title : String?
    var user : User?
    var viewCount : Int?
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.allowApply <-- "allow_apply"
        mapper <<<
            self.applyBtn <-- "apply_btn"
        mapper <<<
            self.commentCount <-- "comment_count"
        mapper <<<
            self.commentDisabled <-- "comment_disabled"
        mapper <<<
            self.createdAt <-- "created_at"
        mapper <<<
            self.displayFullContent <-- "display_full_content"
//        mapper <<<
//            self.webpage <-- "webpage"
    }
}
