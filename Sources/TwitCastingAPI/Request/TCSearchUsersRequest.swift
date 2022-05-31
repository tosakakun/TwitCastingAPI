//
//  TCSearchUsersRequest.swift
//  TwitCastingAPI
//
//  Created by 佐藤真樹 on 2022/05/31.
//

import Foundation

/// ユーザを検索する。
struct TCSearchUsersRequest: TCBaseRequest {
    
    typealias Request = Parameter
    typealias Response = TCUsersResponse
    
    var path: String {
        "/search/users"
    }
    
    let token: String

    struct Parameter: Encodable {
        ///スペース区切りで複数単語のAND検索
        let words: String
        /// 取得件数（min: 1, max: 50, default: 10）
        let limit: Int
        /// 検索対象のユーザの言語設定（現在 "ja" のみ対応）
        let lang: TwitCastingAPI.UsersLang
    }
}
