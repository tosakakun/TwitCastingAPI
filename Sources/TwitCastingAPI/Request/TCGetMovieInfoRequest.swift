//
//  TCGetMovieInfoRequest.swift
//  TwitCastingAPI
//
//  Created by 佐藤真樹 on 2022/05/28.
//

import Foundation

/// ライブ（録画）情報を取得する。
struct TCGetMovieInfoRequest: TCBaseRequest {
    
    typealias Request = TCEmptyRequest
    typealias Response = TCMovieInfoResponse
    
    var path: String {
        "/movies/\(movieId)"
    }
    
    let token: String
    /// ライブID
    let movieId: String

}
