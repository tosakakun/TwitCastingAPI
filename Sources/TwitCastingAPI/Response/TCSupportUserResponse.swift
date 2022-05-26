//
//  TCSupportUserResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/06.
//

import Foundation

/// Support User のレスポンス
public struct TCSupportUserResponse: Codable {
    
    /// サポーター登録を行った件数
    public let addedCount: Int
    
    /// イニシャライザ
    /// - Parameter addedCount: サポーター登録を行った件数
    public init(addedCount: Int) {
        self.addedCount = addedCount
    }

}
