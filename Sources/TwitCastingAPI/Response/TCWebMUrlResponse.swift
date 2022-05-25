//
//  TCWebMUrlResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/08.
//

import Foundation

/// Get WebM Url のレスポンス
public struct TCWebMUrlResponse: Codable {
    
    /// WebM配信が有効かどうか
    public let enabled: Bool
    /// WebM配信用URL
    public let url: String?
    
}
