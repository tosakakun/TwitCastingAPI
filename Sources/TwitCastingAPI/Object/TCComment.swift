//
//  TCComment.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/01.
//

import Foundation

/// コメントを表すオブジェクト
public struct TCComment: Codable, Identifiable {
    
    /// コメントID
    public let id: String
    /// コメント本文
    public let message: String
    /// コメント投稿者の情報 Userオブジェクト
    public let fromUser: TCUser
    /// コメント投稿日時のunixタイムスタンプ
    public let created: Int
    
}
