//
//  TCWebHook.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/08.
//

import Foundation

/// WebHookを表すオブジェクト
public struct TCWebHook: Codable {
    
    /// ユーザID
    public let userId: String
    /// フックするイベント種別(ライブ開始:"livestart", ライブ終了:"liveend")
    public let event: String
    
}
