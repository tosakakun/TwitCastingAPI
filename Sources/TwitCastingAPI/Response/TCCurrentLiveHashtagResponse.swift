//
//  TCCurrentLiveHashtagResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/04/30.
//

import Foundation

public struct TCCurrentLiveHashtagResponse: Codable {
    
    /// ライブID
    public let movieId: String
    /// ハッシュタグ
    public let hashtag: String?
    
}
