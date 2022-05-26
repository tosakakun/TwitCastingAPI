//
//  TCUnsupportUserResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/06.
//

import Foundation

/// Unsupport User のレスポンス
public struct TCUnsupportUserResponse: Codable {
    
    /// サポーター解除を行った件数
    public let removedCount: Int
    
    public init(removedCount: Int) {
        self.removedCount = removedCount
    }

}
