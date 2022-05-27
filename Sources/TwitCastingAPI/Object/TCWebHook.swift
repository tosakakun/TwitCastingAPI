//
//  TCWebHook.swift
//  TwitCastingAPI
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
    
    /// イニシャライザ
    /// - Parameters:
    ///   - userId: ユーザID
    ///   - event: フックするイベント種別(ライブ開始:"livestart", ライブ終了:"liveend")
    public init(userId: String, event: String) {
        self.userId = userId
        self.event = event
    }

}
