//
//  TCGetUserInfoRequest.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/28.
//

import Foundation

/// ユーザ情報を取得する。
struct TCGetUserInfoRequest: TCBaseRequest {

    typealias Request = TCEmptyRequest
    typealias Response = TCUserInfoResponse
    
    var path: String {
        "/users/" + userId
    }
    
    let token: String
    
    /// ユーザの id または screen_id
    let userId: String
    
}
