//
//  TCSearchLiveMoviesRequest.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/31.
//

import Foundation

/// 配信中のライブを検索する。
struct TCSearchLiveMoviesRequest: TCBaseRequest {
    
    typealias Request = Parameter
    typealias Response = TCLiveMoviesResponse
    
    var path: String {
        "/search/lives"
    }
    
    let token: String
    
    struct Parameter: Encodable {
        /// 取得件数（min: 1, max: 100, default: 10）
        let limit: Int
        /// 検索種別（"tag", "word", "category", "new", "recommend"）
        let type: TwitCastingAPI.LiveMoviesType
        /// type=tag or word → スペース区切りで複数単語のAND検索. type=category → サブカテゴリID. type=new or recommend → 不要
        let context: String?
        /// 検索対象のライブ配信者の言語設定（現在 "ja" のみ対応）
        let lang: TwitCastingAPI.LiveMoviesLang
    }
}
