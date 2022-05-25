//
//  TCUsersResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/07.
//

import Foundation

/// ユーザー検索のレスポンス
struct TCUsersResponse: Codable {
    
    /// Userオブジェクトの配列
    let users: [TCUser]
    
}
