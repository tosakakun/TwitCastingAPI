//
//  TCWebHookListResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/08.
//

import Foundation

/// Get WebHook List のレスポンス
public struct TCWebHookListResponse: Codable {
    
    /// 登録済みWebHook件数
    public let allCount: Int
    /// WebHookオブジェクト の配列
    public let webhooks: [TCWebHook]
    
}
