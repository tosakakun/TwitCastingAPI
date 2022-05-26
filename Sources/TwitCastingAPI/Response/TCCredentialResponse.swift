//
//  TCCredentialResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/04/24.
//

import Foundation

/// Verify Credentials のレスポンス
public struct TCCredentialResponse: Codable {
    
    /// アクセストークンに紐づくアプリケーション情報 Appオブジェクト
    public let app: TCApp
    /// アクセストークンに紐づくユーザ情報 Userオブジェクト
    public let user: TCUser
    /// ユーザーのサポーターの数
    public let supporterCount: Int
    /// ユーザーがサポートしている数
    public let supportingCount: Int
    
    /// イニシャライザ
    /// - Parameters:
    ///   - app: アクセストークンに紐づくアプリケーション情報 Appオブジェクト
    ///   - user: アクセストークンに紐づくユーザ情報 Userオブジェクト
    ///   - supporterCount: ユーザーのサポーターの数
    ///   - supportingCount: ユーザーがサポートしている数
    public init(app: TCApp, user: TCUser, supporterCount: Int, supportingCount: Int) {
        self.app = app
        self.user = user
        self.supporterCount = supporterCount
        self.supportingCount = supportingCount
    }

}
