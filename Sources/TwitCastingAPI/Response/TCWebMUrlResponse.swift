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
    
    /// イニシャライザ
    /// - Parameters:
    ///   - enabled: WebM配信が有効かどうか
    ///   - url: WebM配信用URL
    public init(enabled: Bool, url: String?) {
        self.enabled = enabled
        self.url = url
    }

}
