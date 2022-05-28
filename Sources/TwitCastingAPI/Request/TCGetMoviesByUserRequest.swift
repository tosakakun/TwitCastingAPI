//
//  TCGetMoviesByUserRequest.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/28.
//

import Foundation

/// ユーザーが保有する過去ライブ（録画）の一覧を作成日時の降順で取得する。
struct TCGetMoviesByUserRequest: TCBaseRequest {
    
    typealias Request = Parameters
    typealias Response = TCMoviesByUserResponse
    
    var path: String {
        "/users/\(userId)/movies"
    }
    
    let token: String
    /// ユーザーID
    let userId: String
    
    /// リクエストパラメータ
    struct Parameters: Encodable {
        // 先頭からの位置（min:0, max:1000, default:0）
        let offset: Int
        // 最大取得件数(場合により、指定件数に満たない数の動画を返す可能性があります)（min:1, max:50, default:20）
        let limit: Int
        // このID以前のMovieを取得します。このパラメータを指定した場合はoffsetは無視されます。（min:1 default:none）
        let sliceId: String?
    }
    
}
