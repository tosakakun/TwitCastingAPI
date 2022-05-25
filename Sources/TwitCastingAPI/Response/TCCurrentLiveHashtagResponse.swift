//
//  TCCurrentLiveHashtagResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/04/30.
//

import Foundation

struct TCCurrentLiveHashtagResponse: Codable {
    
    /// ライブID
    let movieId: String
    /// ハッシュタグ
    let hashtag: String?
    
}
