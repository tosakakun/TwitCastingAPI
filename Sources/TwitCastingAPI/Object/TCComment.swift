//
//  TCComment.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/01.
//

import Foundation

/// コメントを表すオブジェクト
struct TCComment: Codable, Identifiable {
    
    /// コメントID
    let id: String
    /// コメント本文
    let message: String
    /// コメント投稿者の情報 Userオブジェクト
    let fromUser: TCUser
    /// コメント投稿日時のunixタイムスタンプ
    let created: Int
    
}
