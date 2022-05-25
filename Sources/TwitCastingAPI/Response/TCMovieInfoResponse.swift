//
//  TCMovieInfoResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/04/25.
//

import Foundation

struct TCMovieInfoResponse: Codable {
    
    /// Movie オブジェクト
    let movie: TCMovie
    /// 配信者のユーザ情報 Userオブジェクト
    let broadcaster: TCUser
    /// 設定されているタグの配列
    let tags: [String]
    
}

extension TCMovieInfoResponse: Identifiable {
    var id: String {
        movie.id
    }
}
