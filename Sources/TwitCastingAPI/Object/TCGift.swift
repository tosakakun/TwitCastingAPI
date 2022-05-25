//
//  TCGift.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/02.
//

import Foundation

/// アイテムを表すオブジェクト
struct TCGift: Codable, Identifiable {
    
    /// アイテム送信ID
    let id: Int
    /// アイテム送信時のメッセージ本文
    let message: String
    /// アイテム画像のURL
    let itemImage: String
    /// アイテム送信時に選択された画像があれば画像のURL
    let itemSubImage: String?
    /// アイテムのID
    let itemId: String
    /// アイテムのMP
    /// ドキュメントでは item_mp の型は、string となっているが、実際は、int の値が返ってきている
    let itemMp: Int
    /// アイテム名
    let itemName: String
    /// ユーザアイコンのURL
    let userImage: String
    /// アイテムが送信された時点でのユーザーの screen_id
    let userScreenId: String
    /// ヒューマンリーダブルな screen_id
    let userScreenName: String
    /// ヒューマンリーダブルなユーザの名前
    let userName: String
    
}
