//
//  TCPostCommentResponse.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/01.
//

import Foundation

/// Post Comment のレスポンス
public struct TCPostCommentResponse: Codable {
    
    /// ライブID
    public let movieId: String
    /// 総コメント数
    public let allCount: Int
    /// Commentオブジェクト
    public let comment: TCComment
    
    /// イニシャライザ
    /// - Parameters:
    ///   - movieId: ライブID
    ///   - allCount: 総コメント数
    ///   - comment: Commentオブジェクト
    public init(movieId: String, allCount: Int, comment: TCComment) {
        self.movieId = movieId
        self.allCount = allCount
        self.comment = comment
    }

}
