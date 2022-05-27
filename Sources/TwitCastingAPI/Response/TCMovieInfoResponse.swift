//
//  TCMovieInfoResponse.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/04/25.
//

import Foundation

/// Get Movie Info のレスポンス
public struct TCMovieInfoResponse: Codable {
    
    /// Movie オブジェクト
    public let movie: TCMovie
    /// 配信者のユーザ情報 Userオブジェクト
    public let broadcaster: TCUser
    /// 設定されているタグの配列
    public let tags: [String]
    
    /// イニシャライザ
    /// - Parameters:
    ///   - movie: Movie オブジェクト
    ///   - broadcaster: 配信者のユーザ情報 Userオブジェクト
    ///   - tags: 設定されているタグの配列
    public init(movie: TCMovie, broadcaster: TCUser, tags: [String]) {
        self.movie = movie
        self.broadcaster = broadcaster
        self.tags = tags
    }
    
}

extension TCMovieInfoResponse: Identifiable {
    public var id: String {
        movie.id
    }
}
