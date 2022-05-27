//
//  TCCategory.swift
//  TwitCastingAPI
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
    
    /// イニシャライザ
    /// - Parameters:
    ///   - id: カテゴリID
    ///   - name: カテゴリ名
    ///   - subCategories: Sub categoryオブジェクトの配列
    public init(id: String, name: String, subCategories: [TCSubCategory]) {
        self.id = id
        self.name = name
        self.subCategories = subCategories
    }

}
