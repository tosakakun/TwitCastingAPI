//
//  TCUser.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/04/19.
//

import Foundation

/// ユーザを表すオブジェクト
struct TCUser: Codable, Identifiable {
    /// ユーザーID
    let id: String
    /// id同様にユーザを特定する識別子ですが、screen_idはユーザによって変更される場合があります。
    let screenId: String
    /// ヒューマンリーダブルなユーザの名前
    let name: String
    /// ユーザアイコンのURL
    let image: String
    /// プロフィール文章
    let profile: String
    /// ユーザのレベル
    let level: Int
    /// ユーザが最後に配信したライブのID
    let lastMovieId: String?
    /// 現在ライブ配信中かどうか
    let isLive: Bool

}
