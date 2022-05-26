//
//  TCRemoveWebHookResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/08.
//

import Foundation

/// Remove WebHook のレスポンス
public struct TCRemoveWebHookResponse: Codable {
    
    /// ユーザID
    public let userId: String
    /// 削除されたイベント種別(ライブ開始:"livestart", ライブ終了:"liveend")の配列
    public let deletedEvents: [String]
    
    /// イニシャライザ
    /// - Parameters:
    ///   - userId: ユーザID
    ///   - deletedEvents: 削除されたイベント種別(ライブ開始:"livestart", ライブ終了:"liveend")の配列
    public init(userId: String, deletedEvents: [String]) {
        self.userId = userId
        self.deletedEvents = deletedEvents
    }

}
