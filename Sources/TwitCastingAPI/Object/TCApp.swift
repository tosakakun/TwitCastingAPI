//
//  TCApp.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/04/24.
//

import Foundation

/// アプリケーションを表すオブジェクト
struct TCApp: Codable {
    
    /// アプリケーションのクライアントID
    let clientId: String
    /// アプリケーション名
    let name: String
    /// アプリケーション開発者のユーザID
    let ownerUserId: String

}
