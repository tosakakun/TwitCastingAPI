//
//  TCLiveMoviesResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/07.
//

import Foundation

/// 配信中のライブ検索のレスポンス
struct TCLiveMoviesResponse: Codable {
    
    /// /movies/:movie_id と同一のMovieオブジェクトの配列
    let movies: [TCMovieInfoResponse]
    
}
