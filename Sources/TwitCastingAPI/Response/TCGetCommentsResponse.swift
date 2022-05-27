//
//  TCGetCommentsResponse.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/01.
//

import Foundation

/// Get Comments のレスポンス
public struct TCGetCommentsResponse: Codable {
    
    /// ライブID
    public let movieId: String
    /// 総コメント数
    public let allCount: Int
    /// Commentオブジェクトの配列
    public let comments: [TCComment]
    
    /// イニシャライザ
    /// - Parameters:
    ///   - movieId: ライブID
    ///   - allCount: 総コメント数
    ///   - comments: Commentオブジェクトの配列
    public init(movieId: String, allCount: Int, comments: [TCComment]) {
        self.movieId = movieId
        self.allCount = allCount
        self.comments = comments
    }

}
