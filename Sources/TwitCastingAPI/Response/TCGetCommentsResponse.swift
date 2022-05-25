//
//  TCGetCommentsResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/01.
//

import Foundation

public struct TCGetCommentsResponse: Codable {
    
    /// ライブID
    public let movieId: String
    /// 総コメント数
    public let allCount: Int
    /// Commentオブジェクトの配列
    public let comments: [TCComment]
    
}
