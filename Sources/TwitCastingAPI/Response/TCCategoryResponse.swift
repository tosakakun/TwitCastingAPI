//
//  TCCategoryResponse.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/06.
//

import Foundation

/// Get Categories のレスポンス
public struct TCCategoryResponse: Codable {
    
    /// Categoryオブジェクトの配列
    public let categories: [TCCategory]
    
    /// イニシャライザ
    /// - Parameter categories: Categoryオブジェクトの配列
    public init(categories: [TCCategory]) {
        self.categories = categories
    }

}
