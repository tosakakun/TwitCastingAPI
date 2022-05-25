//
//  TCMovie.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/04/25.
//

import Foundation

/// ライブ（録画）を表すオブジェクト
public struct TCMovie: Codable, Identifiable {
    
    /// ライブID
    public let id: String
    /// ライブ配信者のユーザーID
    public let userId: String
    /// タイトル
    public let title: String
    /// テロップ
    public let subtitle: String?
    /// ライブ配信者の最新コメントの文章
    public let lastOwnerComment: String?
    /// カテゴリID
    public let category: String?
    /// ライブ(録画)へのリンクURL
    public let link: String
    /// ライブ配信中かどうか
    public let isLive: Bool
    /// 録画が公開されているかどうか
    public let isRecorded: Bool
    /// 総コメント数
    public let commentCount: Int
    /// サムネイル画像(大)のURL
    public let largeThumbnail: String
    /// サムネイル画像(小)のURL
    public let smallThumbnail: String
    /// 配信地域(国コード)
    public let country: String
    /// 配信時間(秒)
    public let duration: Int
    /// 配信開始日時のunixタイムスタンプ
    public let created: Int
    /// コラボ配信かどうか
    public let isCollabo: Bool
    /// 合言葉配信かどうか
    public let isProtected: Bool
    /// 最大同時視聴数(配信中の場合0)
    public let maxViewCount: Int
    /// 現在の同時視聴者数(配信中ではない場合0)
    public let currentViewCount: Int
    /// 総視聴者数
    public let totalViewCount: Int
    /// HTTP Live Streaming再生用のURL
    public let hlsUrl: String?
    
}
