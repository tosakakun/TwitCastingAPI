//
//  TCGetCategoriesRequest.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/31.
//

import Foundation

/// 配信中のライブがあるカテゴリのみを取得する。
struct TCGetCategoriesRequest: TCBaseRequest {
    
    typealias Request = Parameter
    typealias Response = TCCategoryResponse
    
    var path: String {
        "/categories"
    }
    
    let token: String
    
    struct Parameter: Encodable {
        /// 検索対象の言語
        let lang: TwitCastingAPI.CategoryLang
    }
    
}
