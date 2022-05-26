//
//  TCRegisterWebHookResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/08.
//

import Foundation

/// Register WebHook のレスポンス
public struct TCRegisterWebHookResponse: Codable {
    
    /// ユーザID
    public let userId: String
    /// 登録されたイベント種別(ライブ開始:"livestart", ライブ終了:"liveend")の配列
    public let addedEvents: [String]
    
    /// イニシャライザ
    /// - Parameters:
    ///   - userId: ユーザID
    ///   - addedEvents: 登録されたイベント種別(ライブ開始:"livestart", ライブ終了:"liveend")の配列
    public init(userId: String, addedEvents: [String]) {
        self.userId = userId
        self.addedEvents = addedEvents
    }

}
