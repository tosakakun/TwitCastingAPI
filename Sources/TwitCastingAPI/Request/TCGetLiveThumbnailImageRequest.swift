//
//  TCGetLiveThumbnailImageRequest.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/05/31.
//

import Foundation

/// 配信中のライブのサムネイル画像を取得する。
struct TCGetLiveThumbnailImageRequest: TCBaseRequest {
    
    typealias Request = Parameter
    typealias Response = Data
    
    var path: String {
        "/users/\(userId)/live/thumbnail"
    }
    
    let token: String = ""
    /// ユーザの id または screen_id のいずれか
    let userId: String

    struct Parameter: Encodable {
        /// 画像サイズ
        let size: TwitCastingAPI.LiveThumbnailImageSize
        /// サムネイル取得位置
        let position: TwitCastingAPI.LiveThumbnailImagePosition
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
        
        guard let url = url else {
            throw TCError.unknownError(message: "url is nil")
        }
        
        var urlRequest = try method.urlRequest(url: url, data: data)
        urlRequest.allHTTPHeaderFields = defaultHeaderFields.merging(headerFields, uniquingKeysWith: { _, new  in
            new
        })
        
        // リクエストを送信
        let (responseData, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpURLResponse = response as? HTTPURLResponse else {
            throw TCError.unknownError(message: "can not cast to HTTPURLResponse")
        }
        
        if httpURLResponse.statusCode == 302,
            let location = httpURLResponse.value(forHTTPHeaderField: "Location"),
            let redirectURL = URL(string: location) {
            
            let secondRequest = URLRequest(url: redirectURL)
            
            let (data, _) = try await URLSession.shared.data(for: secondRequest)
            
            return data
            
        }
        
        return responseData
        
    }

}
