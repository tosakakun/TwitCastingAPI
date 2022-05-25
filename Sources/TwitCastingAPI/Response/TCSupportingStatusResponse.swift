//
//  TCSupportingStatusResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/02.
//

import Foundation

public struct TCSupportingStatusResponse: Codable {
    
    /// サポーターかどうか
    public let isSupporting: Bool
    /// サポートした日時のunixタイムスタンプ
    public let supported: Int?
    /// 対象ユーザ情報 Userオブジェクト
    public let targetUser: TCUser
    
}
