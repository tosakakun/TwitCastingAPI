//
//  TCUserInfoResponse.swift
//  TwitCastingAPI
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
    
    /// イニシャライザ
    /// - Parameters:
    ///   - user: Userオブジェクト
    ///   - supporterCount: ユーザーのサポーター数
    ///   - supportingCount: ユーザーがサポートしている数
    public init(user: TCUser, supporterCount: Int, supportingCount: Int) {
        self.user = user
        self.supporterCount = supporterCount
        self.supportingCount = supportingCount
    }

}
