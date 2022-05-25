//
//  TCGift.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/02.
//

import Foundation

/// アイテムを表すオブジェクト
public struct TCGift: Codable, Identifiable {
    
    /// アイテム送信ID
    public let id: Int
    /// アイテム送信時のメッセージ本文
    public let message: String
    /// アイテム画像のURL
    public let itemImage: String
    /// アイテム送信時に選択された画像があれば画像のURL
    public let itemSubImage: String?
    /// アイテムのID
    public let itemId: String
    /// アイテムのMP
    /// ドキュメントでは item_mp の型は、string となっているが、実際は、int の値が返ってきている
    public let itemMp: Int
    /// アイテム名
    public let itemName: String
    /// ユーザアイコンのURL
    public let userImage: String
    /// アイテムが送信された時点でのユーザーの screen_id
    public let userScreenId: String
    /// ヒューマンリーダブルな screen_id
    public let userScreenName: String
    /// ヒューマンリーダブルなユーザの名前
    public let userName: String
    
}
