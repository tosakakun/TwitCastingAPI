//
//  TCGiftsResponse.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/05/02.
//

import Foundation

public struct TCGiftsResponse: Codable {
    
    /// 次にAPIを呼び出すときに指定する slice_id
    public let sliceId: Int
    /// Giftオブジェクトの配列
    public let gifts: [TCGift]
    
    enum CodingKeys: String, CodingKey {
        case sliceId
        case gifts
    }
    
    public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // 送信されたアイティムがない場合、slice_id として文字列の "-1" が返ってくるが、
        // 送信されたアイティムが存在する場合は、slice_id として整数の値が返ってくる模様。
        // ドキュメント( https://apiv2-doc.twitcasting.tv/#get-gifts )によると
        // slice_id の型は int となっているのでそれに合わせて Int 型とする。
        // そのためまず文字列型への変換を試み、変換できた("-1")ら更に整数型へ変換し、sliceIdへ代入。
        // 文字列型に変換できなかった場合、整数型への変換を試み、変換できたらそのまま値をsliceIdへ代入する。
        // 万一どちらも失敗した場合は -1 を代入しておく。
        if let stringSliceId = try? container.decode(String.self, forKey: .sliceId), let intSliceId = Int(stringSliceId) {
            sliceId = intSliceId
        } else if let intSliceId = try? container.decode(Int.self, forKey: .sliceId) {
            sliceId = intSliceId
        } else {
            print("slice_id をデコードできませんでした: -1")
            sliceId = -1
        }
        
        self.gifts = try container.decode([TCGift].self, forKey: .gifts)
        
    }
    
}
