//
//  TCVerifyCredentialsRequest.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/28.
//

import Foundation

/// アクセストークンを検証し、ユーザ情報を取得する。
struct TCverifyCredentialsRequest: TCBaseRequest {
    
    typealias Response = TCCredentialResponse
    typealias Request = TCEmptyRequest
    
    var path: String {
        "/verify_credentials"
    }
    
    let token: String
    
}
