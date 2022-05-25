//
//  TwitCastingAuth.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/04/19.
//

import Foundation

import AuthenticationServices
import Security

public class TwitCastingAuth: NSObject, ObservableObject {

    /// アクセストークン
    @Published public var token = "" {
        didSet {
            save(token: token)
        }
    }
    
    /// トークン失効日時
    public var expirationDate = 0.0 {
        didSet {
            save(expirationDate: expirationDate)
        }
    }
    
    /// Verify Credentials のレスポンス
    @Published public var credentialResponse: TCCredentialResponse?
    /// 認証処理中のエラー
    @Published public var error: TCError?

    /// クライアントID
    private let clientId: String
    /// コールバックURLスキーム
    private let callbackURLScheme: String
    /// CSRFトークン
    private var csrfToken: String?
    
    /// イニシャライザ
    /// - Parameters:
    ///   - clientId: クライアントID
    ///   - callbackURLScheme: コールバックURLスキーム
    public init(clientId: String, callbackURLScheme: String) {
        
        self.clientId = clientId
        self.callbackURLScheme = callbackURLScheme
        
        super.init()
        
        // トークン失効日時を復元
        self.expirationDate = loadExpirationDate()
        
        if let token = loadToken() {

            self.token = token
            
            Task {
                // トークンの検証とユーザー情報の取得
                await verifyCredentials()
            }
            
        }
        
    }

    /// ログインする
    public func login() {
        
        // CSRFトークンを生成
        self.csrfToken = createCSRFToken(count: 16)
        
        let url = URL(string: "https://apiv2.twitcasting.tv/oauth2/authorize")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "client_id", value: clientId),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "state", value: self.csrfToken)
        ]
        
        let authSession = ASWebAuthenticationSession(url: components.url!, callbackURLScheme: self.callbackURLScheme) { url, error in
            
            if let error = error {
                self.error = TCError.unknownError(code: 401, message: error.localizedDescription)
                print(error.localizedDescription)
            } else if let url = url {
                self.processResponseURL(url: url)
            } else {
                print("unknown error")
                self.error = TCError.unknownError(code: 401, message: "no callback URL")
            }
            
        }
        
        authSession.presentationContextProvider = self
        authSession.prefersEphemeralWebBrowserSession = true
        authSession.start()

    }
    
    /// ログアウト
    public func logout() {
        self.token = ""
        self.expirationDate = 0
        self.credentialResponse = nil
        // キーチェーンからトークンとトークン失効日時を削除
        deleteToken()
        deleteExpirationDate()
    }
    
    // MARK: - Private Method
    
    /// コールバックURLからトークン、トークンタイプ、トークンが執行するまでの秒数を取得する
    /// - Parameter url: コールバックURL
    private func processResponseURL(url: URL) {
        
        guard
            let urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: true),
                let fragment = urlComponent.fragment,
                let dummyURL = URL(string: "https://dummy.com?\(fragment)"),
                let queryItems = URLComponents(url: dummyURL, resolvingAgainstBaseURL: true)?.queryItems else {
            print("queryItems を取得できませんでした")
            self.error = TCError.unknownError(code: 401, message: "can not retrieve queryItems")
            return
        }
        
        // キャンセルのとき
        if let denied = queryItems.filter({ $0.name == "result" }).first?.value, denied == "denied" {
            print("キャンセルされました")
            return
        }
        
        // CSRFトークンチェック
        guard let csrfToken = queryItems.filter({ $0.name == "state"}).first?.value,
              csrfToken == self.csrfToken else {
            print("CSRFトークンが一致しません")
            self.error = TCError.unknownError(code: 401, message: "CSRF token does not match.")
            return
        }
        
        // アクセストークンを取得
        guard let token = queryItems.filter({ $0.name == "access_token"}).first?.value else {
            print("token を取得できませんでした")
            self.error = TCError.unknownError(code: 401, message: "can not retrieve token")
            return
        }
        
        self.token = token
        
        // トークンが失効するまでの秒数を取得
        guard let expiresIn = queryItems.filter({ $0.name == "expires_in" }).first?.value else {
            print("expiresIn を取得できませんでした")
            return
        }
        
        // トークン執行日時を算出
        self.expirationDate = Date().timeIntervalSince1970 + (TimeInterval(expiresIn) ?? 0.0)

        // ユーザー情報を取得する
        Task {
            await verifyCredentials()
        }
        
    }
    
    /// アクセストークンを検証し、ユーザ情報を取得する。
    private func verifyCredentials() async {
        
        let api = TwitCastingAPI()
        
        do {
            
            let response = try await api.verifyCredentials(token: token)
            
            DispatchQueue.main.async {
                self.credentialResponse = response
            }

        } catch let error as TCError {
            print(error.localizedDescription)
            self.error = error
            // エラーが発生したらログアウト
            logout()
        } catch {
            print(error.localizedDescription)
            self.error = TCError.unknownError(messeage: error.localizedDescription)
            // エラーが発生したらログアウト
            logout()
        }
        
    }

    /// CSRFトークンを生成する
    /// - Parameter count: バイト数
    /// - Returns: CSRFトークン
    private func createCSRFToken(count: Int) -> String? {
        
        var bytes = [Int8](repeating: 0, count: count)
        
        let status = SecRandomCopyBytes(kSecRandomDefault, count, &bytes)
        
        if status == errSecSuccess {
            
            let data = Data(bytes: bytes, count: count)
            
            return data.base64EncodedString()
            
        } else {
            return nil
        }
        
    }
    
    
    /// アクセストークンをキーチェーンに保存する
    /// - Parameter token: アクセストークン
    private func save(token: String) {
        KeyChain.save(key: "token", value: token)
    }
    
    /// アクセストークンをキーチェーンから取得する
    /// - Returns: アクセストークン
    private func loadToken() -> String? {
        KeyChain.load(key: "token")
    }
    
    /// アクセストークンをキーチェーンから削除する
    private func deleteToken() {
        KeyChain.delete(key: "token")
    }

    /// アクセストークン失効日時をキーチェーンに保存する
    /// - Parameter expirationDate: トークン執行日時
    private func save(expirationDate: TimeInterval) {
        KeyChain.save(key: "expirationDate", value: "\(expirationDate)")
    }
    
    
    /// アクセストークン失効日時をキーチェーンから取得する
    /// - Returns: アクセストークン失効日時
    private func loadExpirationDate() -> TimeInterval {
        
        guard let expirationDateString = KeyChain.load(key: "expirationDate"), let expirationDate = TimeInterval(expirationDateString) else {
            return TimeInterval(0)
        }
        
        return expirationDate

    }
    
    /// アクセストークン失効日時
    private func deleteExpirationDate() {
        KeyChain.delete(key: "expirationDate")
    }
    
}


// MARK: - ASWebAuthenticationPresentationContextProviding
extension TwitCastingAuth: ASWebAuthenticationPresentationContextProviding {
    
    public func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        ASPresentationAnchor()
    }
    
}


// MARK: - KeyChain
fileprivate enum KeyChain {
    
    @discardableResult
    /// キーチェーンにデータを保存する
    /// - Parameters:
    ///   - key: キー
    ///   - value: 値
    /// - Returns: OSStatus
    static func save(key: String, value: String) -> OSStatus {
        
        let bytes: [UInt8] = Array(value.utf8)
        let data = Data(bytes)
        
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: data
        ] as [CFString: Any]
        
        SecItemDelete(query as CFDictionary)
        
        return SecItemAdd(query as CFDictionary, nil)
        
    }

    /// キーチェーンからデータを取得する
    /// - Parameter key: キー
    /// - Returns: String?
    static func load(key: String) -> String? {
        
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitOne
        ] as [CFString: Any]
        
        var typeRef: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &typeRef)
        
        if status == noErr {
            
            guard let data = typeRef as? Data else {
                return nil
            }
            
            return String(decoding: data, as: UTF8.self)
            
        } else {
            return nil
        }
        
    }

    @discardableResult
    /// キーチェーンからデータを削除する
    /// - Parameter key: キー
    /// - Returns: OSStatus
    static func delete(key: String) -> OSStatus {
        
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
        ] as [CFString: Any]
        
        return SecItemDelete(query as CFDictionary)

    }
    
}
