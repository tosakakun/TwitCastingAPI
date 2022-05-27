//
//  TCCurrentLiveResponse.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/04/26.
//

import Foundation

// Get Current Live のレスポンス
public struct TCCurrentLiveResponse: Codable {
    
    /// Movieオブジェクト
    public let movie: TCMovie
    /// 配信者のユーザ情報 Userオブジェクト
    public let broadcaster: TCUser
    /// 設定されているタグの配列
    public let tags: [String]
    
    /// イニシャライザ
    /// - Parameters:
    ///   - movie: Movieオブジェクト
    ///   - broadcaster: 配信者のユーザ情報 Userオブジェクト
    ///   - tags: 設定されているタグの配列
    public init(movie: TCMovie, broadcaster: TCUser, tags: [String]) {
        self.movie = movie
        self.broadcaster = broadcaster
        self.tags = tags
    }
    
}
