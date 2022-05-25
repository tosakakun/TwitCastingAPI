//
//  TCSupporterUser.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/06.
//

import Foundation

/// サポーターユーザを表すオブジェクト (point, supported, total_point を除いて Userオブジェクト と同じです)
struct TCSupporterUser: Codable, Identifiable {
    
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
    /// サポートした日時のunixタイムスタンプ
    let supported: Int
    /// ユーザをサポートしている人数
    let supporterCount: Int
    /// ユーザがサポートしている人数
    let supportingCount: Int
    /// アイテム・スコア
    let point: Int
    /// 累計スコア
    let totalPoint: Int
    
}

extension TCSupporterUser {
    
    /// ユーザを表すオブジェクトを取得する
    var user: TCUser {
        TCUser(id: id, screenId: screenId, name: name, image: image, profile: profile, level: level, lastMovieId: lastMovieId, isLive: isLive)
    }
    
}
