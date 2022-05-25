//
//  TCRTMPUrlResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/08.
//

import Foundation

/// Get RTMP Url のレスポンス
struct TCRTMPUrlResponse: Codable {
    
    /// RTMP配信が有効かどうか
    let enabled: Bool
    /// RTMP配信用URL
    let url: String?
    /// RTMP配信用キー
    let streamKey: String?
    
}
