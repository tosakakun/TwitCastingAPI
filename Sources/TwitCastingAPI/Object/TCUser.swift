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

}
