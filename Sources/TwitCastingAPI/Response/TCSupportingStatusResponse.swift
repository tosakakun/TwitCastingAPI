//
//  TCSupportingStatusResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/02.
//

import Foundation

struct TCSupportingStatusResponse: Codable {
    
    /// サポーターかどうか
    let isSupporting: Bool
    /// サポートした日時のunixタイムスタンプ
    let supported: Int?
    /// 対象ユーザ情報 Userオブジェクト
    let targetUser: TCUser
    
}
