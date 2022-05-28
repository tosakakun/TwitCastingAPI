//
//  TCGetCommentsRequest.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/28.
//

import Foundation

/// コメントを作成日時の降順で取得する
struct TCGetCommentsRequest: TCBaseRequest {
    
    typealias Request = Parameter
    typealias Response = TCGetCommentsResponse
    
    var path: String {
        "/movies/\(movieId)/comments"
    }
    
    let token: String
    /// ライブID
    let movieId: String
    
    struct Parameter: Encodable {
        /// 先頭からの位置
        let offset: Int
        /// 取得件数(場合により、指定件数に満たない数のコメントを返す可能性があります)（min:1, max:50, default:10）
        let limit: Int
        /// このコメントID以降のコメントを取得します。このパラメータを指定した場合はoffsetは無視されます。（min:1, default:none）
        let sliceId: String?
    }
    
}
