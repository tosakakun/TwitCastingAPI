//
//  MockURLProtocol.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/06/01.
//

import Foundation

final class MockURLProtocol: URLProtocol {
    
    typealias RequestHandler = ((URLRequest) throws -> (HTTPURLResponse, Data?))
    
    static var requestHandler: RequestHandler?
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        
        guard let requestHandler = Self.requestHandler else {
            fatalError("RequestHandler is nil")
        }

        do {
            
            let (response, data) = try requestHandler(request)
            
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            
            if let data = data {
                client?.urlProtocol(self, didLoad: data)
            }
            
            client?.urlProtocolDidFinishLoading(self)
            
        } catch {
            
            client?.urlProtocol(self, didFailWithError: error)
            
        }

    }
    
    override func stopLoading() {
    }
    
}
