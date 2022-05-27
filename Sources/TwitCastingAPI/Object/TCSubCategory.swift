//
//  TCSubCategory.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/06.
//

import Foundation

/// 配信サブカテゴリを表すオブジェクト
public struct TCSubCategory: Codable, Identifiable {
    
    /// サブカテゴリID
    public let id: String
    /// サブカテゴリ名
    public let name: String
    /// サブカテゴリ配信数
    public let count: Int
    
    /// イニシャライザ
    /// - Parameters:
    ///   - id: サブカテゴリID
    ///   - name: サブカテゴリ名
    ///   - count: サブカテゴリ配信数
    public init(id: String, name: String, count: Int) {
        self.id = id
        self.name = name
        self.count = count
    }

}
