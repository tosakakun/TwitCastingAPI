//
//  TCSupportingListRequest.swift
//  
//
//  Created by tosakakun on 2022/05/31.
//

import Foundation

/// 指定したユーザーがサポートしているユーザーの一覧を取得する
struct TCSupportingListRequest: TCBaseRequest {
    
    typealias Request = Parameter
    typealias Response = TCSupportingListResponse
    
    var path: String {
        "/users/\(userId)/supporting"
    }
    
    let token: String
    /// ユーザの id または screen_id のいずれか
    let userId: String
    
    struct Parameter: Encodable {
        /// 先頭からの位置（min:0, default:0）
        let offset: Int
        /// 取得件数（min:1, max:20, default:20）
        let limit: Int
    }
    
}
