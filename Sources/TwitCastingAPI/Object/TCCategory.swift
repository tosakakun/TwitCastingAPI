//
//  TCCategory.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/06.
//

import Foundation

/// 配信カテゴリを表すオブジェクト
struct TCCategory: Codable, Identifiable {
    
    /// カテゴリID
    let id: String
    /// カテゴリ名
    let name: String
    /// Sub categoryオブジェクトの配列
    let subCategories: [TCSubCategory]
    
}
