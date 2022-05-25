//
//  TCMoviesByUserResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/04/25.
//

import Foundation

struct TCMoviesByUserResponse: Codable {
    
    /// 指定フィルター条件での総件数
    let totalCount: Int
    /// Movieオブジェクト の配列
    let movies: [TCMovie]
    
}
