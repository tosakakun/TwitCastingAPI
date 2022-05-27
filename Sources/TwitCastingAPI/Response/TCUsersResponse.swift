//
//  TCUsersResponse.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/07.
//

import Foundation

/// ユーザー検索のレスポンス
public struct TCUsersResponse: Codable {
    
    /// Userオブジェクトの配列
    public let users: [TCUser]
    
    /// イニシャライザ
    /// - Parameter users: Userオブジェクトの配列
    public init(users: [TCUser]) {
        self.users = users
    }

}
