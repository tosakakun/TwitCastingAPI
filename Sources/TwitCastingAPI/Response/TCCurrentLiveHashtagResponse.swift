//
//  TCCurrentLiveHashtagResponse.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/04/30.
//

import Foundation

/// Set Current Live Hashtag のレスポンス
public struct TCCurrentLiveHashtagResponse: Codable {
    
    /// ライブID
    public let movieId: String
    /// ハッシュタグ
    public let hashtag: String?
    
    /// イニシャライザ
    /// - Parameters:
    ///   - movieId: ライブID
    ///   - hashtag: ハッシュタグ
    public init(movieId: String, hashtag: String?) {
        self.movieId = movieId
        self.hashtag = hashtag
    }

}
