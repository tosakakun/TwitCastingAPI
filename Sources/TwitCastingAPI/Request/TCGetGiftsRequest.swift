//
//  TCGetGiftsRequest.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/31.
//

import Foundation

/// アクセストークンに紐づくユーザに直近10秒程度の間に送信されたアイテムを取得する。
struct TCGetGiftsRequest: TCBaseRequest {
    
    typealias Request = Parameter
    typealias Response = TCGiftsResponse
    
    var path: String {
        "/gifts"
    }
    
    let token: String
    
    struct Parameter: Encodable {
        /// このアイテム送信ID以降に送信されたアイテムを取得します
        let sliceId: Int
    }

}
