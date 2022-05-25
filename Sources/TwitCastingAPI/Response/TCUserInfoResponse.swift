//
//  TCUserInfoResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/04/19.
//

import Foundation

/// Get User Info のレスポンス
struct TCUserInfoResponse: Codable {
    
    /// Userオブジェクト
    let user: TCUser
    /// ユーザーのサポーター数
    let supporterCount: Int
    /// ユーザーがサポートしている数
    let supportingCount: Int

}
