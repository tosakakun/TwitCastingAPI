//
//  TCSupportUserRequest.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/31.
//

import Foundation

/// 指定したユーザーのサポーターになる
struct TCSupportUserRequest: TCBaseRequest {
    
    typealias Request = Parameter
    typealias Response = TCSupportUserResponse
    
    var path: String {
        "/support"
    }
    
    var method: HTTPMethod {
        .put
    }
    
    let token: String
    
    struct Parameter: Encodable {
        /// 対象ユーザの id または screen_id の配列（配列内の要素数 20 以下）
        let targetUserIds: [String]
    }
    
}
