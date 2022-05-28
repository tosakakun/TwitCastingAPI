//
//  TCDeleteCommentRequest.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/28.
//

import Foundation

/// コメントを削除する。 ユーザ単位でのみ実行可能です。 なお、原則として削除できるコメントは、投稿者がアクセストークンに紐づくユーザと同一のものに限られます。 ただし、Movieのオーナーであるユーザーのアクセストークンを用いる場合は他ユーザが投稿したコメントを削除することが出来ます。
struct TCDeleteCommentRequest: TCBaseRequest {
    
    typealias Request = TCEmptyRequest
    typealias Response = TCDeleteCommentResponse
    
    var path: String {
        "/movies/\(movieId)/comments/\(commentId)"
    }
    
    var method: HTTPMethod {
        .delete
    }
    
    let token: String
    /// ライブID
    let movieId: String
    /// コメントID
    let commentId: String
    
}
