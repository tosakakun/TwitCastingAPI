//
//  TCCurrentLiveResponse.swift
//  TwitCastingAPIDev
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
    
}
