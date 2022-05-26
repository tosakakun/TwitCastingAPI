//
//  TCSupporterUser.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/06.
//

import Foundation

/// サポーターユーザを表すオブジェクト (point, supported, total_point を除いて Userオブジェクト と同じです)
public struct TCSupporterUser: Codable, Identifiable {
    
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
    /// サポートした日時のunixタイムスタンプ
    public let supported: Int
    /// ユーザをサポートしている人数
    public let supporterCount: Int
    /// ユーザがサポートしている人数
    public let supportingCount: Int
    /// アイテム・スコア
    public let point: Int
    /// 累計スコア
    public let totalPoint: Int
    
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
    ///   - supported: サポートした日時のunixタイムスタンプ
    ///   - supporterCount: ユーザをサポートしている人数
    ///   - supportingCount: ユーザがサポートしている人数
    ///   - point: アイテム・スコア
    ///   - totalPoint: 累計スコア
    public init(id: String, screenId: String, name: String, image: String, profile: String, level: Int, lastMovieId: String?, isLive: Bool, supported: Int, supporterCount: Int, supportingCount: Int, point: Int, totalPoint: Int) {
        self.id = id
        self.screenId = screenId
        self.name = name
        self.image = image
        self.profile = profile
        self.level = level
        self.lastMovieId = lastMovieId
        self.isLive = isLive
        self.supported = supported
        self.supporterCount = supporterCount
        self.supportingCount = supportingCount
        self.point = point
        self.totalPoint = totalPoint
    }

}

extension TCSupporterUser {
    
    /// ユーザを表すオブジェクトを取得する
    public var user: TCUser {
        TCUser(id: id, screenId: screenId, name: name, image: image, profile: profile, level: level, lastMovieId: lastMovieId, isLive: isLive)
    }
    
}
