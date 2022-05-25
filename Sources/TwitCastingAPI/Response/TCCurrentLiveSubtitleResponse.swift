//
//  TCCurrentLiveSubtitleResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/04/30.
//

import Foundation

public struct TCCurrentLiveSubtitleResponse: Codable {
    
    /// ライブID
    public let movieId: String
    /// テロップ
    public let subtitle: String?
    
}
