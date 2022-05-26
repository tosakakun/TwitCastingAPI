//
//  TCSupporterListResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/06.
//

import Foundation

/// Supporter List のレスポンス
public struct TCSupporterListResponse: Codable {
    
    /// 全レコード数(実際に取得できる件数と異なる場合があります)
    public let total: Int
    /// SupporterUserオブジェクトの配列
    public let supporters: [TCSupporterUser]
    
    /// イニシャライザ
    /// - Parameters:
    ///   - total: 全レコード数(実際に取得できる件数と異なる場合があります)
    ///   - supporters: SupporterUserオブジェクトの配列
    public init(total: Int, supporters: [TCSupporterUser]) {
        self.total = total
        self.supporters = supporters
    }

}
