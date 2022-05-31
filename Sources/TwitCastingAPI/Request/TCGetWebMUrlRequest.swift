//
//  TCGetWebMUrlRequest.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/31.
//

import Foundation

/// アクセストークンに紐づくユーザの配信用のURL (WebM, WebSocket)を取得する。
struct TCGetWebMUrlRequest: TCBaseRequest {
    
    typealias Request = TCEmptyRequest
    typealias Response = TCWebMUrlResponse
    
    var path: String {
        "/webm_url"
    }
    
    let token: String
    
}
