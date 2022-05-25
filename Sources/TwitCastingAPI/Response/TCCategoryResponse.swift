//
//  TCCategoryResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/06.
//

import Foundation

struct TCCategoryResponse: Codable {
    
    /// Categoryオブジェクトの配列
    let categories: [TCCategory]
    
}
