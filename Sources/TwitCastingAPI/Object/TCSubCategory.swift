//
//  TCSubCategory.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/06.
//

import Foundation

/// 配信サブカテゴリを表すオブジェクト
struct TCSubCategory: Codable, Identifiable {
    
    /// サブカテゴリID
    let id: String
    /// サブカテゴリ名
    let name: String
    /// サブカテゴリ配信数
    let count: Int
    
}
