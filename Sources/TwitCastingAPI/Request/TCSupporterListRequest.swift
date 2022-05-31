//
//  TCSupporterListRequest.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/31.
//

import Foundation

/// 指定したユーザーをサポートしているユーザーの一覧を取得する。
struct TCSupporterListRequest: TCBaseRequest {
    
    typealias Request = Parameter
    typealias Response = TCSupporterListResponse
    
    var path: String {
        "/users/\(userId)/supporters"
    }
    
    let token: String
    /// ユーザの id または screen_id のいずれか
    let userId: String
    
    struct Parameter: Encodable {
        /// 先頭からの位置（min:0, defalut:0）
        let offset: Int
        /// 取得件数（min:1, max:20, default:20）
        let limit: Int
        /// ソート順（新着順: "new", 貢献度順: "ranking"）
        let sort: TwitCastingAPI.SupporterSort
    }

}
