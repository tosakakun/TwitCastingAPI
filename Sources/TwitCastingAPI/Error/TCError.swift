//
//  TCError.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/04/24.
//

import Foundation

/// エラー
enum TCError: Error {
    /// アクセストークンが不正な時
    case invalidToken(code: Int, message: String)
    /// バリデーションエラー時
    case validationError(code: Int, message: String, details: [String: [String]]?)
    /// WebHook URL の登録が必要なAPIで、URLが登録されていない または URLの形式が不正な時
    case invalidWebHookURL(code: Int, message: String)
    /// API実行回数上限
    case executionCountLimitation(code: Int, message: String)
    /// アプリケーションが無効になっている時（サポートへお問い合わせください）
    case applicationDisabled(code: Int, message: String)
    /// コンテンツが保護されている時 (合言葉配信等)
    case protected(code: Int, message: String)
    /// 多重投稿時 (連続で同じコメントを送信した時等)
    case duplicate(code: Int, message: String)
    /// コメント数が上限に達している時 (一定数以上のコメントがある配信で、配信が終了している場合にこのエラーが発生することがあります)
    case tooManyComments(code: Int, message: String)
    /// 書込み・配信などの権限がない時
    case outOfScope(code: Int, message: String)
    /// Emailの確認が済んでおらず機能が利用できない時
    case emailUnverified(code: Int, message: String)
    /// パラメータが不正な時 (バリデーション上問題ないが、パラメータで指定した対象が存在しない場合等)
    case badRequest(code: Int, message: String)
    /// 権限の無いリソースへのアクセス時
    case forbidden(code: Int, message: String)
    /// コンテンツが見つからない時
    case notFound(code: Int, message: String)
    /// その他のエラー
    case internalServerError(code: Int, message: String)
    /// デコード失敗等その他のエラー
    case unknownError(code: Int, message: String)
}

extension TCError {
    
    static func unknownError(messeage: String? = nil) -> TCError {
        TCError.unknownError(code: 9999, message: messeage ?? "unknown error")
    }
    
    var localizedDescription: String {
        
        switch self {
        case .validationError(let code, let message, let details):
            return errorMessage(code: code, message: message, details: details)
        case .invalidToken(let code, let message):
            return errorMessage(code: code, message: message)
        case .invalidWebHookURL(let code, let message):
            return errorMessage(code: code, message: message)
        case .executionCountLimitation(let code, let message):
            return errorMessage(code: code, message: message)
        case .applicationDisabled(let code, let message):
            return errorMessage(code: code, message: message)
        case .protected(let code, let message):
            return errorMessage(code: code, message: message)
        case .duplicate(let code, let message):
            return errorMessage(code: code, message: message)
        case .tooManyComments(let code, let message):
            return errorMessage(code: code, message: message)
        case .outOfScope(let code, let message):
            return errorMessage(code: code, message: message)
        case .emailUnverified(let code, let message):
            return errorMessage(code: code, message: message)
        case .badRequest(let code, let message):
            return errorMessage(code: code, message: message)
        case .forbidden(let code, let message):
            return errorMessage(code: code, message: message)
        case .notFound(let code, let message):
            return errorMessage(code: code, message: message)
        case .internalServerError(let code, let message):
            return errorMessage(code: code, message: message)
        case .unknownError(let code, let message):
            return errorMessage(code: code, message: message)
        }
    }
    
    private func errorMessage(code: Int, message: String, details: [String:[String]]? = nil) -> String {
        "Error \(code) : \(message) \(details ?? [String:[String]]())"
    }
    
}

/// Errorオブジェクト
fileprivate struct TCRawError: Codable {
    /// エラー識別コード
    let code: Int
    /// ヒューマンリーダブルなエラーメッセージ
    let message: String
    /// Validation Errorの場合のみ存在するフィールド
    let details: [String: [String]]?

}

struct TCErrorResponse: Codable {
    
    fileprivate let rawError: TCRawError
    
    enum CodingKeys: String, CodingKey {
        case rawError = "error"
    }
    
}

extension TCErrorResponse {

    var error: TCError {
        
        let code = rawError.code
        let message = rawError.message
        let details = rawError.details
        
        switch code {
        case 1000:
            return TCError.invalidToken(code: code, message: message)
        case 1001:
            return TCError.validationError(code: code, message: message, details: details)
        case 1002:
            return TCError.invalidWebHookURL(code: code, message: message)
        case 2000:
            return TCError.executionCountLimitation(code: code, message: message)
        case 2001:
            return TCError.applicationDisabled(code: code, message: message)
        case 2002:
            return TCError.protected(code: code, message: message)
        case 2003:
            return TCError.duplicate(code: code, message: message)
        case 2004:
            return TCError.tooManyComments(code: code, message: message)
        case 2005:
            return TCError.outOfScope(code: code, message: message)
        case 2006:
            return TCError.emailUnverified(code: code, message: message)
        case 400:
            return TCError.badRequest(code: code, message: message)
        case 403:
            return TCError.forbidden(code: code, message: message)
        case 404:
            return TCError.notFound(code: code, message: message)
        case 500:
            return TCError.internalServerError(code: code, message: message)
        default:
            return TCError.unknownError(code: 9999, message: "unknown error")
        }
    }
}
