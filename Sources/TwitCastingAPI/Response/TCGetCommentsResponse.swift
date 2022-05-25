//
//  TCGetCommentsResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/01.
//

import Foundation

struct TCGetCommentsResponse: Codable {
    
    /// ライブID
    let movieId: String
    /// 総コメント数
    let allCount: Int
    /// Commentオブジェクトの配列
    let comments: [TCComment]
    
}
