//
//  TCDeleteCommentResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/01.
//

import Foundation

/// Delete Comment のレスポンス
public struct TCDeleteCommentResponse: Codable {
    
    /// 削除したコメントのID
    public let commentId: String
    
    /// イニシャライザ
    /// - Parameter commentId: 削除したコメントのID
    public init(commentId: String) {
        self.commentId = commentId
    }
    
}
