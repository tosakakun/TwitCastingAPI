//
//  TCApp.swift
//  TwitCastingAPIDev
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

}
