//
//  TCCurrentLiveSubtitleResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/04/30.
//

import Foundation

struct TCCurrentLiveSubtitleResponse: Codable {
    
    /// ライブID
    let movieId: String
    /// テロップ
    let subtitle: String?
    
}
