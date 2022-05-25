//
//  TCCategoryResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/06.
//

import Foundation

public struct TCCategoryResponse: Codable {
    
    /// Categoryオブジェクトの配列
    public let categories: [TCCategory]
    
}
