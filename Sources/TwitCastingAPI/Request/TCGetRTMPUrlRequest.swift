//
//  TCGetRTMPUrlRequest.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/31.
//

import Foundation

/// アクセストークンに紐づくユーザの配信用のURL(RTMP)を取得する。
struct TCGetRTMPUrlRequest: TCBaseRequest {

    typealias Request = TCEmptyRequest
    typealias Response = TCRTMPUrlResponse
    
    var path: String {
        "/rtmp_url"
    }
    
    let token: String
    
}
