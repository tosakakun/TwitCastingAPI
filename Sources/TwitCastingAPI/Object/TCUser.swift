//
//  TCUser.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/04/19.
//

import Foundation

/// ユーザを表すオブジェクト
public struct TCUser: Codable, Identifiable {
    /// ユーザーID
    public let id: String
    /// id同様にユーザを特定する識別子ですが、screen_idはユーザによって変更される場合があります。
    public let screenId: String
    /// ヒューマンリーダブルなユーザの名前
    public let name: String
    /// ユーザアイコンのURL
    public let image: String
    /// プロフィール文章
    public let profile: String
    /// ユーザのレベル
    public let level: Int
    /// ユーザが最後に配信したライブのID
    public let lastMovieId: String?
    /// 現在ライブ配信中かどうか
    public let isLive: Bool
    
    /// イニシャライザ
    /// - Parameters:
    ///   - id: ユーザーID
    ///   - screenId: id同様にユーザを特定する識別子ですが、screen_idはユーザによって変更される場合があります。
    ///   - name: ヒューマンリーダブルなユーザの名前
    ///   - image: ユーザアイコンのURL
    ///   - profile: プロフィール文章
    ///   - level: ユーザのレベル
    ///   - lastMovieId: ユーザが最後に配信したライブのID
    ///   - isLive: 現在ライブ配信中かどうか
    public init(id: String, screenId: String, name: String, image: String, profile: String, level: Int, lastMovieId: String?, isLive: Bool) {
        self.id = id
        self.screenId = screenId
        self.name = name
        self.image = image
        self.profile = profile
        self.level = level
        self.lastMovieId = lastMovieId
        self.isLive = isLive
    }

}
