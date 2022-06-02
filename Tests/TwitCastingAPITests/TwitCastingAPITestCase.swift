//
//  TwitCastingAPITestCase.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/06/02.
//

import Foundation
import XCTest

class TwitCastingAPITestCase: XCTestCase {
    
    override func setUp() async throws {
        try await super.setUp()
        URLProtocol.registerClass(MockURLProtocol.self)
    }
    
    override func tearDown() async throws {
        URLProtocol.unregisterClass(MockURLProtocol.self)
        try await super.tearDown()
    }
    
    func setMockData(fileName: String, statusCode: Int = 200) {
        
        MockURLProtocol.requestHandler = { request in
            
            let response = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
            
            guard let jsonUrl = Bundle.module.url(forResource: "JsonFiles/\(fileName)", withExtension: "json"),
                  let jsonData = try? String(contentsOf: jsonUrl) else {
                      fatalError("\(fileName).json not found")
                  }
            
            let data = jsonData.data(using: .utf8)
            
            return (response, data)
            
        }
        
    }
    
}
