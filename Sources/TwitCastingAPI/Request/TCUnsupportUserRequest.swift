//
//  TCUnsupportUserRequest.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/31.
//

import Foundation

/// 指定したユーザーのサポーター状態を解除する
struct TCUnsupportUserRequest: TCBaseRequest {
    
    typealias Request = Parameter
    typealias Response = TCUnsupportUserResponse
    
    var path: String {
        "/unsupport"
    }
    
    var method: HTTPMethod {
        .put
    }
    
    let token: String
    
    struct Parameter: Encodable {
        /// 対象ユーザの id または screen_id の配列
        let targetUserIds: [String]
    }
    
}
