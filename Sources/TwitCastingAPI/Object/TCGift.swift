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
    
    /// イニシャライザ
    /// - Parameters:
    ///   - id: アイテム送信ID
    ///   - message: アイテム送信時のメッセージ本文
    ///   - itemImage: アイテム画像のURL
    ///   - itemSubImage: アイテム送信時に選択された画像があれば画像のURL
    ///   - itemId: アイテムのID
    ///   - itemMp: アイテムのMP
    ///   - itemName: アイテム名
    ///   - userImage: ユーザアイコンのURL
    ///   - userScreenId: アイテムが送信された時点でのユーザーの screen_id
    ///   - userScreenName: ヒューマンリーダブルな screen_id
    ///   - userName: ヒューマンリーダブルなユーザの名前
    public init(id: Int, message: String, itemImage: String, itemSubImage: String?, itemId: String, itemMp: Int, itemName: String, userImage: String, userScreenId: String, userScreenName: String, userName: String) {
        self.id = id
        self.message = message
        self.itemImage = itemImage
        self.itemSubImage = itemSubImage
        self.itemId = itemId
        self.itemMp = itemMp
        self.itemName = itemName
        self.userImage = userImage
        self.userScreenId = userScreenId
        self.userScreenName = userScreenName
        self.userName = userName
    }
}
