//
//  TCPostCommentResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/01.
//

import Foundation

public struct TCPostCommentResponse: Codable {
    
    /// ライブID
    public let movieId: String
    /// 総コメント数
    public let allCount: Int
    /// Commentオブジェクト
    public let comment: TCComment
    
}
