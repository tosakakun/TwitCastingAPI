//
//  TCSupportingListResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/06.
//

import Foundation

/// Supporting List のレスポンス
public struct TCSupportingListResponse: Codable {
    
    /// 全レコード数(実際に取得できる件数と異なる場合があります)
    public let total: Int
    /// SupporterUserオブジェクトの配列
    public let supporting: [TCSupporterUser]
    
    /// イニシャライザ
    /// - Parameters:
    ///   - total: 全レコード数(実際に取得できる件数と異なる場合があります)
    ///   - supporting: SupporterUserオブジェクトの配列
    public init(total: Int, supporting: [TCSupporterUser]) {
        self.total = total
        self.supporting = supporting
    }

}
