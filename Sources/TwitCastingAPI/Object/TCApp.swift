//
//  TCApp.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/04/24.
//

import Foundation

/// アプリケーションを表すオブジェクト
public struct TCApp: Codable {
    
    /// アプリケーションのクライアントID
    public let clientId: String
    /// アプリケーション名
    public let name: String
    /// アプリケーション開発者のユーザID
    public let ownerUserId: String

    /// イニシャライザ
    /// - Parameters:
    ///   - clientId: アプリケーションのクライアントID
    ///   - name: アプリケーション名
    ///   - ownerUserId: アプリケーション開発者のユーザID
    public init(clientId: String, name: String, ownerUserId: String) {
        self.clientId = clientId
        self.name = name
        self.ownerUserId = ownerUserId
    }
    
}
