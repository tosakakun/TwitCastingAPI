//
//  TCGetCurrentLiveRequest.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/28.
//

import Foundation

/// ユーザーが配信中の場合、ライブ情報を取得する。
struct TCGetCurrentLiveRequest: TCBaseRequest {
    
    typealias Request = TCEmptyRequest
    typealias Response = TCCurrentLiveResponse
    
    var path: String {
        "/users/" + userId + "/current_live"
    }
    
    let token: String
    /// ユーザの id または screen_id のいずれか
    let userId: String
    
}
