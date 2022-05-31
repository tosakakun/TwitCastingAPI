//
//  TCGetSupportingStatusRequest.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/31.
//

import Foundation

/// ユーザーが、ある別のユーザのサポーターであるかの状態を取得する。
struct TCGetSupportingStatusRequest: TCBaseRequest {
    
    typealias Request = Parameter
    typealias Response = TCSupportingStatusResponse
    
    var path: String {
        "/users/\(userId)/supporting_status"
    }
    
    let token: String
    /// ユーザの id または screen_id のいずれか
    let userId: String
    
    struct Parameter: Encodable {
        /// 対象ユーザの id または screen_id
        let targetUserId: String
    }
    
}
