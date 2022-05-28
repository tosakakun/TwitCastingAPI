//
//  TCPostCommentRequest.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/28.
//

import Foundation

struct TCPostCommentRequest: TCBaseRequest {
    
    typealias Request = Parameter
    typealias Response = TCPostCommentResponse
    
    var path: String {
        "/movies/\(movieId)/comments"
    }
    
    var method: HTTPMethod {
        .post
    }
    
    let token: String
    /// ライブID
    let movieId: String
    
    struct Parameter: Encodable {
        /// 投稿するコメント文章（1〜140文字）
        let comment: String
        /// SNSへの同時投稿(ユーザーがTwitterまたはFacebookと連携しているときのみ有効)。"reply" → 配信者へリプライする形式で投稿, "normal" → 通常の投稿, "none" → SNS投稿無し
        let sns: TwitCastingAPI.SNS
    }

}
