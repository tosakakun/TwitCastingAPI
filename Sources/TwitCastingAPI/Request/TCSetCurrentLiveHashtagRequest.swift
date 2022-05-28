//
//  TCSetCurrentLiveHashtagRequest.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/28.
//

import Foundation

/// ユーザーが配信中の場合、ライブのハッシュタグを設定する
struct TCSetCurrentLiveHashtagRequest: TCBaseRequest {
    
    typealias Request = Parameter
    typealias Response = TCCurrentLiveHashtagResponse
    
    var path: String {
        "/movies/hashtag"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    let token: String
    
    struct Parameter: Encodable {
        /// ハッシュタグ
        let hashtag: String
    }
    
}
