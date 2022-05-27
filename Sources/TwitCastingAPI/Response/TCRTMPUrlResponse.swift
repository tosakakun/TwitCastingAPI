//
//  TCRTMPUrlResponse.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/08.
//

import Foundation

/// Get RTMP Url のレスポンス
public struct TCRTMPUrlResponse: Codable {
    
    /// RTMP配信が有効かどうか
    public let enabled: Bool
    /// RTMP配信用URL
    public let url: String?
    /// RTMP配信用キー
    public let streamKey: String?
    
    /// イニシャライザ
    /// - Parameters:
    ///   - enabled: RTMP配信が有効かどうか
    ///   - url: RTMP配信用URL
    ///   - streamKey: RTMP配信用キー
    public init(enabled: Bool, url: String?, streamKey: String?) {
        self.enabled = enabled
        self.url = url
        self.streamKey = streamKey
    }

}
