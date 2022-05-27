//
//  TCCurrentLiveSubtitleResponse.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/04/30.
//

import Foundation

/// Set Current Live Subtitle, Unset Current Live Subtitle のレスポンス
public struct TCCurrentLiveSubtitleResponse: Codable {
    
    /// ライブID
    public let movieId: String
    /// テロップ
    public let subtitle: String?
    
    /// イニシャライザ
    /// - Parameters:
    ///   - movieId: ライブID
    ///   - subtitle: テロップ
    public init(movieId: String, subtitle: String?) {
        self.movieId = movieId
        self.subtitle = subtitle
    }

}
