//
//  TCBaseRequest.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/28.
//

import Foundation

/// HTTP メソッドの種類
enum HTTPMethod: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    
    /// URLRequest を作成する
    /// - Parameters:
    ///   - url: URL
    ///   - data: リクエストパラメータ、あるいはボディーデータ
    /// - Returns: URLRequest
    func urlRequest(url: URL, data: Data?) throws -> URLRequest {
        
        var request = URLRequest(url: url)
        
        switch self {
        case .get:
            
            guard let data = data else {
                request.httpMethod = rawValue
                return request
            }
            
            // リクエストパラメータを取得して設定
            guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                throw TCError.unknownError(message: "can not create URLComponents")
            }
            
            guard let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any?] else {
                throw TCError.unknownError(message: "can not comvert data to dictionary")
            }
            
            components.queryItems = dictionary.compactMap({ key, value in
                guard let value = value else {
                    return nil
                }
                return URLQueryItem(name: key, value: "\(value)")
            })
            
            guard let getUrl = components.url else {
                throw TCError.unknownError(message: "can not get url from URLComponents")
            }
            
            print("GET with parameters URL: \(getUrl)")
            
            var request = URLRequest(url: getUrl)
            request.httpMethod = rawValue
            return request
            
        case .post, .put, .delete:
            request.httpMethod = rawValue
            request.httpBody = data
            return request

        }

    }

}

struct TCEmptyRequest: Encodable {
}

/// リクエストのベース
protocol TCBaseRequest {

    associatedtype Request: Encodable
    
    associatedtype Response: Decodable
    
    /// ベースURL
    var baseUrl: String { get }
    /// アクセストークン
    var token: String { get }
    /// パス
    var path: String { get }
    /// URL
    var url: URL? { get }
    /// HTTPメソッド
    var method: HTTPMethod { get }
    /// HTTPヘッダー
    var headerFields: [String: String] { get }
    /// JSONエンコーダー
    var encoder: JSONEncoder { get }
    /// JSONデコーダー
    var decoder: JSONDecoder { get }
    
    /// リクエストを送信する
    /// - Parameter parameter: リクエストパラメータ
    /// - Returns: Response
    func send(parameter: Request?) async throws -> Response
    
}

/// リクエストのデフォルト実装
extension TCBaseRequest {
    
    var baseUrl: String {
        "https://apiv2.twitcasting.tv"
    }
    
    var url: URL? {
        URL(string: baseUrl + path)
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headerFields: [String: String] {
        [String: String]()
    }
    
    var defaultHeaderFields: [String: String] {
        [
            "X-Api-Version": "2.0",
            "Authorization": "Bearer \(token)"
        ]
    }
    
    var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
    
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    func send(parameter: Request? = nil) async throws -> Response {
        
        var data: Data? = nil
        
        if let parameter = parameter {
            do {
                data = try encoder.encode(parameter)
            } catch {
                throw TCError.unknownError(message: "can not encode request parameters")
            }
        }
        
        return try await send(data: data)
        
    }
    
    /// リクエストを送信する
    /// - Parameter data: リクエストで送信するデータ
    /// - Returns: Response
    private func send(data: Data?) async throws -> Response {
        
        guard let url = url else {
            throw TCError.unknownError(message: "url is nil")
        }
        
        var urlRequest = try method.urlRequest(url: url, data: data)
        urlRequest.allHTTPHeaderFields = defaultHeaderFields.merging(headerFields, uniquingKeysWith: { _, new  in
            new
        })
        
        // リクエストを送信
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpURLResponse = response as? HTTPURLResponse else {
            throw TCError.unknownError(message: "can not cast to HTTPURLResponse")
        }
        
        // レスポンスヘッダの情報を取得
        TwitCastingAPI.xRateLimitLimit = Int(httpURLResponse.value(forHTTPHeaderField: "X-RateLimit-Limit")  ?? "0") ?? 0
        TwitCastingAPI.xRateLimitRemaining = Int(httpURLResponse.value(forHTTPHeaderField: "X-RateLimit-Remaining") ?? "0") ?? 0
        TwitCastingAPI.xRateLimitReset = Int(httpURLResponse.value(forHTTPHeaderField: "X-RateLimit-Reset") ?? "0") ?? 0
        
        guard httpURLResponse.statusCode == 200 || httpURLResponse.statusCode == 201 else {
            
            // ステータスコードが 200, 201 以外ならツイキャスエラーにデコードしてスローする
            if let errorResponse = try? decoder.decode(TCErrorResponse.self, from: data) {
                throw errorResponse.error
            } else {
                // 不明なエラー
                throw TCError.unknownError(code: httpURLResponse.statusCode, message: "can not decode error response")
            }
            
        }
        
        // ツイキャスAPIのレスポンスをデコードする
        guard let object = try? decoder.decode(Response.self, from: data) else {
            throw TCError.unknownError(message: "can not decode response")
        }
            
        return object
        
    }

}
