//
//  TCCredentialResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/04/24.
//

import Foundation

/// Verify Credentials のレスポンス
struct TCCredentialResponse: Codable {
    
    /// アクセストークンに紐づくアプリケーション情報 Appオブジェクト
    let app: TCApp
    /// アクセストークンに紐づくユーザ情報 Userオブジェクト
    let user: TCUser
    /// ユーザーのサポーターの数
    let supporterCount: Int
    /// ユーザーがサポートしている数
    let supportingCount: Int
    
}
