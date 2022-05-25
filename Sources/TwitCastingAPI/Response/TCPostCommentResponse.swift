//
//  TCPostCommentResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/01.
//

import Foundation

struct TCPostCommentResponse: Codable {
    
    /// ライブID
    let movieId: String
    /// 総コメント数
    let allCount: Int
    /// Commentオブジェクト
    let comment: TCComment
    
}
