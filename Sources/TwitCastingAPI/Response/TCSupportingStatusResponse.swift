//
//  TCSupportingStatusResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/02.
//

import Foundation

/// Get Supporting Status のレスポンス
public struct TCSupportingStatusResponse: Codable {
    
    /// サポーターかどうか
    public let isSupporting: Bool
    /// サポートした日時のunixタイムスタンプ
    public let supported: Int?
    /// 対象ユーザ情報 Userオブジェクト
    public let targetUser: TCUser
    
    /// イニシャライザ
    /// - Parameters:
    ///   - isSupporting: サポーターかどうか
    ///   - supported: サポートした日時のunixタイムスタンプ
    ///   - targetUser: 対象ユーザ情報 Userオブジェクト
    public init(isSupporting: Bool, supported: Int?, targetUser: TCUser) {
        self.isSupporting = isSupporting
        self.supported = supported
        self.targetUser = targetUser
    }

}
