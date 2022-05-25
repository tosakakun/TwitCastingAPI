//
//  TCWebHookListResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/08.
//

import Foundation

/// Get WebHook List のレスポンス
struct TCWebHookListResponse: Codable {
    
    /// 登録済みWebHook件数
    let allCount: Int
    /// WebHookオブジェクト の配列
    let webhooks: [TCWebHook]
    
}
