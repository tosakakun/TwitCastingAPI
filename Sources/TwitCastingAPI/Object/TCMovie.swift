//
//  TCMovie.swift
//  TwitCastingAPIDev
//
//  Created by tosakakun on 2022/04/25.
//

import Foundation

/// ライブ（録画）を表すオブジェクト
struct TCMovie: Codable, Identifiable {
    
    /// ライブID
    let id: String
    /// ライブ配信者のユーザーID
    let userId: String
    /// タイトル
    let title: String
    /// テロップ
    let subtitle: String?
    /// ライブ配信者の最新コメントの文章
    let lastOwnerComment: String?
    /// カテゴリID
    let category: String?
    /// ライブ(録画)へのリンクURL
    let link: String
    /// ライブ配信中かどうか
    let isLive: Bool
    /// 録画が公開されているかどうか
    let isRecorded: Bool
    /// 総コメント数
    let commentCount: Int
    /// サムネイル画像(大)のURL
    let largeThumbnail: String
    /// サムネイル画像(小)のURL
    let smallThumbnail: String
    /// 配信地域(国コード)
    let country: String
    /// 配信時間(秒)
    let duration: Int
    /// 配信開始日時のunixタイムスタンプ
    let created: Int
    /// コラボ配信かどうか
    let isCollabo: Bool
    /// 合言葉配信かどうか
    let isProtected: Bool
    /// 最大同時視聴数(配信中の場合0)
    let maxViewCount: Int
    /// 現在の同時視聴者数(配信中ではない場合0)
    let currentViewCount: Int
    /// 総視聴者数
    let totalViewCount: Int
    /// HTTP Live Streaming再生用のURL
    let hlsUrl: String?
    
}
