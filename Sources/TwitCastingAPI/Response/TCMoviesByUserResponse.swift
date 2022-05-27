//
//  TCMoviesByUserResponse.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/04/25.
//

import Foundation

/// Get Movies by User のレスポンス
public struct TCMoviesByUserResponse: Codable {
    
    /// 指定フィルター条件での総件数
    public let totalCount: Int
    /// Movieオブジェクト の配列
    public let movies: [TCMovie]
    
    /// イニシャライザ
    /// - Parameters:
    ///   - totalCount: 指定フィルター条件での総件数
    ///   - movies: Movieオブジェクト の配列
    public init(totalCount: Int, movies: [TCMovie]) {
        self.totalCount = totalCount
        self.movies = movies
    }

}
