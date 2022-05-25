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
    
}
