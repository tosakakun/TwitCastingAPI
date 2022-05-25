//
//  TCWebHook.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/08.
//

import Foundation

/// WebHookを表すオブジェクト
struct TCWebHook: Codable {
    
    /// ユーザID
    let userId: String
    /// フックするイベント種別(ライブ開始:"livestart", ライブ終了:"liveend")
    let event: String
    
}
