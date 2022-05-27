//
//  TCLiveMoviesResponse.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/07.
//

import Foundation

/// 配信中のライブ検索のレスポンス
public struct TCLiveMoviesResponse: Codable {
    
    /// /movies/:movie_id と同一のMovieオブジェクトの配列
    public let movies: [TCMovieInfoResponse]
    
    /// イニシャライザ
    /// - Parameter movies: /movies/:movie_id と同一のMovieオブジェクトの配列
    public init(movies: [TCMovieInfoResponse]) {
        self.movies = movies
    }

}
