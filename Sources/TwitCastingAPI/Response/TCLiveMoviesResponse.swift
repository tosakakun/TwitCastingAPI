//
//  TCLiveMoviesResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/07.
//

import Foundation

/// 配信中のライブ検索のレスポンス
public struct TCLiveMoviesResponse: Codable {
    
    /// /movies/:movie_id と同一のMovieオブジェクトの配列
    public let movies: [TCMovieInfoResponse]
    
}
