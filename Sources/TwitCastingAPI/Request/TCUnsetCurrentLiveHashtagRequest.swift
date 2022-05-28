//
//  TCUnsetCurrentLiveHashtagRequest.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/28.
//

import Foundation

/// ユーザーが配信中の場合、ライブのハッシュタグを解除する
struct TCUnsetCurrentLiveHashtagRequest: TCBaseRequest {
    
    typealias Request = TCEmptyRequest
    typealias Response = TCCurrentLiveHashtagResponse
    
    var path: String {
        "/movies/hashtag"
    }
    
    var method: HTTPMethod {
        .delete
    }
    
    let token: String

}
