//
//  TCSubCategory.swift
//  TwitCastingAPIDev
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
    
}
