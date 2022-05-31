//
//  TCUnsetCurrentLiveSubtitleRequest.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/28.
//

import Foundation

/// ユーザーが配信中の場合、ライブのテロップを解除する
struct TCUnsetCurrentLiveSubtitleRequest: TCBaseRequest {
    
    typealias Request = TCEmptyRequest
    typealias Response = TCCurrentLiveSubtitleResponse
    
    var path: String {
        "/movies/subtitle"
    }
    
    var method: HTTPMethod {
        .delete
    }
    
    let token: String

}
