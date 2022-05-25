//
//  TCUserInfoResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/04/19.
//

import Foundation

/// Get User Info のレスポンス
public struct TCUserInfoResponse: Codable {
    
    /// Userオブジェクト
    public let user: TCUser
    /// ユーザーのサポーター数
    public let supporterCount: Int
    /// ユーザーがサポートしている数
    public let supportingCount: Int

}
