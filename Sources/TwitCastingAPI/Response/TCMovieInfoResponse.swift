//
//  TCMovieInfoResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/04/25.
//

import Foundation

public struct TCMovieInfoResponse: Codable {
    
    /// Movie オブジェクト
    public let movie: TCMovie
    /// 配信者のユーザ情報 Userオブジェクト
    public let broadcaster: TCUser
    /// 設定されているタグの配列
    public let tags: [String]
    
}

extension TCMovieInfoResponse: Identifiable {
    public var id: String {
        movie.id
    }
}
