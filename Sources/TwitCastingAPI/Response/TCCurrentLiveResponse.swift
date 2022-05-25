//
//  TCCurrentLiveResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/04/26.
//

import Foundation

// Get Current Live のレスポンス
struct TCCurrentLiveResponse: Codable {
    
    /// Movieオブジェクト
    let movie: TCMovie
    /// 配信者のユーザ情報 Userオブジェクト
    let broadcaster: TCUser
    /// 設定されているタグの配列
    let tags: [String]
    
}
