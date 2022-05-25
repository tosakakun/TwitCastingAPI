//
//  TCMoviesByUserResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/04/25.
//

import Foundation

public struct TCMoviesByUserResponse: Codable {
    
    /// 指定フィルター条件での総件数
    public let totalCount: Int
    /// Movieオブジェクト の配列
    public let movies: [TCMovie]
    
}
