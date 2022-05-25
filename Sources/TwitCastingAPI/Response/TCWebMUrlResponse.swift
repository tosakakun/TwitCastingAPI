//
//  TCWebMUrlResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/08.
//

import Foundation

/// Get WebM Url のレスポンス
struct TCWebMUrlResponse: Codable {
    
    /// WebM配信が有効かどうか
    let enabled: Bool
    /// WebM配信用URL
    let url: String?
    
}
