//
//  TwitCastingAPIHTTPMethodTests.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/06/01.
//

import XCTest
@testable import TwitCastingAPI

class TwitCastingAPIHTTPMethodTests: XCTestCase {
    
    func testHTTPMethodGet() throws {

        let url = URL(string: "https://apiv2.twitcasting.tv/users/twitcasting_jp")!
        
        let expected = URLRequest(url: url)
        
        let request = TCGetUserInfoRequest(token: "token", userId: "twitcasting_jp")

        let method = HTTPMethod.get
        
        let urlRequest = try method.urlRequest(url: request.url!, data: nil)
        
        XCTAssertEqual(urlRequest, expected)
        
    }
    
    func testHTTPMethodGetWithParameter() throws {
        
        let url = URL(string: "https://apiv2.twitcasting.tv/movies/189037369/comments?offset=10&limit=10")!
        
        let expected = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        let request = TCGetCommentsRequest(token: "token", movieId: "189037369")
        
        let parameter = TCGetCommentsRequest.Parameter(offset: 10, limit: 10, sliceId: nil)
        
        let data = try JSONEncoder().encode(parameter)
        
        let method = HTTPMethod.get
        
        let urlRequest = try method.urlRequest(url: request.url!, data: data)
        
        let components = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: true)!
        
        XCTAssertEqual(components.path, expected.path)
        XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
        XCTAssertEqual(Set(components.queryItems!), Set(expected.queryItems!))

    }
    
    func testHTTPMethodPost() throws {
        
        let url = URL(string: "https://apiv2.twitcasting.tv/movies/189037369/comments")!
        
        var expected = URLRequest(url: url)
        expected.httpMethod = HTTPMethod.post.rawValue
        
        let request = TCPostCommentRequest(token: "token", movieId: "189037369")
        
        let parameter = TCPostCommentRequest.Parameter(comment: "モイ！", sns: .none)
        
        let data = try JSONEncoder().encode(parameter)
        
        let method = HTTPMethod.post
        
        let urlRequest = try method.urlRequest(url: request.url!, data: data)
        
        XCTAssertEqual(urlRequest, expected)
        XCTAssertEqual(urlRequest.httpBody, data)

    }
    
    func testHTTPMethodDelete() throws {
        
        let url = URL(string: "https://apiv2.twitcasting.tv/movies/189037369/comments/123456")!
        
        var expected = URLRequest(url: url)
        expected.httpMethod = HTTPMethod.delete.rawValue
        
        let request = TCDeleteCommentRequest(token: "token", movieId: "189037369", commentId: "123456")
        
        let method = HTTPMethod.delete
        
        let urlRequest = try method.urlRequest(url: request.url!, data: nil)
        
        XCTAssertEqual(urlRequest, expected)
        
    }
    
    func testHTTPMethodPut() throws {
        
        let url = URL(string: "https://apiv2.twitcasting.tv/support")!
        
        var expected = URLRequest(url: url)
        expected.httpMethod = HTTPMethod.put.rawValue
        
        let request = TCSupportUserRequest(token: "token")
        
        let parameter = TCSupportUserRequest.Parameter(targetUserIds: ["casma_jp", "twitcasting_pr"])
        
        let data = try JSONEncoder().encode(parameter)
        
        let method = HTTPMethod.put
        
        let urlRequest = try method.urlRequest(url: request.url!, data: data)
        
        XCTAssertEqual(urlRequest, expected)
        XCTAssertEqual(urlRequest.httpBody, data)

    }
    
}
