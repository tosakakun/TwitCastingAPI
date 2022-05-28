//
//  TCSetCurrentLiveSubtitleRequest.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/28.
//

import Foundation

/// ユーザーが配信中の場合、ライブのテロップを設定する。
struct TCSetCurrentLiveSubtitleRequest: TCBaseRequest {
    
    typealias Request = Parameters
    typealias Response = TCCurrentLiveSubtitleResponse
    
    var path: String {
        "/movies/subtitle"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    let token: String
    
    struct Parameters: Encodable {
        /// テロップ（1〜17文字）
        let subtitle: String
    }

}
