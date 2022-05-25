//
//  TCRegisterWebHookResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/08.
//

import Foundation

/// Register WebHook のレスポンス
struct TCRegisterWebHookResponse: Codable {
    
    /// ユーザID
    let userId: String
    /// 登録されたイベント種別(ライブ開始:"livestart", ライブ終了:"liveend")の配列
    let addedEvents: [String]
    
}
