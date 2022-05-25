//
//  TCCategory.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/06.
//

import Foundation

/// 配信カテゴリを表すオブジェクト
public struct TCCategory: Codable, Identifiable {
    
    /// カテゴリID
    public let id: String
    /// カテゴリ名
    public let name: String
    /// Sub categoryオブジェクトの配列
    public let subCategories: [TCSubCategory]
    
}
