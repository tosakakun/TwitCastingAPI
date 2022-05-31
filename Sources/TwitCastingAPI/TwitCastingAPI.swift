//
//  TwitCastingAPI.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/04/18.
//

import Foundation

public struct TwitCastingAPI {
    
    /// APIの実行上限回数
    public static var xRateLimitLimit = 0
    /// APIの残り実行可能回数
    public static var xRateLimitRemaining = 0
    /// APIの残り実行可能回数がリセットされる時刻のUnixTimestamp
    public static var xRateLimitReset = 0
    
    /// HTTP メソッドの種類
    private enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    /// ライブサムネイル画像サイズ
    public enum LiveThumbnailImageSize: String, CustomStringConvertible, Encodable {
        /// 大
        case large
        /// 小
        case small
        
        public var description: String {
            rawValue
        }
    }
    
    /// ライブサムネイル取得位置
    public enum LiveThumbnailImagePosition: String, CustomStringConvertible, Encodable {
        /// ライブ開始時点
        case beginning
        /// ライブ最新
        case latest
        
        public var description: String {
            rawValue
        }
    }
    
    /// SNSへの同時投稿(ユーザーがTwitterまたはFacebookと連携しているときのみ有効)
    public enum SNS: String, CaseIterable, CustomStringConvertible, Encodable {

        /// 配信者へリプライする形式で投稿
        case reply
        /// 通常の投稿
        case normal
        /// SNS投稿無し
        case none
        
        public var description: String {
            rawValue
        }

    }
    
    /// サポーターリスト取得時のソート順
    public enum SupporterSort: String, CaseIterable, CustomStringConvertible, Encodable {
        /// 新着順
        case new
        /// 貢献度順
        case ranking
        
        public var description: String {
            rawValue
        }
    }
    
    /// カテゴリ検索対象の言語
    public enum CategoryLang: String, CustomStringConvertible, Encodable {
        case ja
        case en
        
        public var description: String {
            rawValue
        }
    }
    
    /// 検索対象のユーザの言語設定
    public enum UsersLang: String, CustomStringConvertible, Encodable {
        case ja
        public var description: String {
            rawValue
        }
    }
    
    /// 配信中のライブ検索の検索種別
    public enum LiveMoviesType: String, CaseIterable, Identifiable, CustomStringConvertible, Encodable {
        case tag
        case word
        case category
        case new
        case recommend
        
        public var id: Self {
            self
        }
        
        public var description: String {
            rawValue
        }
    }
    
    /// 配信中のライブ検索の言語設定
    public enum LiveMoviesLang: String, CustomStringConvertible, Encodable {
        case ja
        
        public var description: String {
            rawValue
        }
    }
    
    /// フックするイベント種別
    public enum WebHookEvent: String {
        /// ライブ開始
        case liveStart = "livestart"
        /// ライブ終了
        case liveEnd = "liveend"
    }
    
    /// Base URL
    private let baseURL = "https://apiv2.twitcasting.tv"
    
    /// JSONデコーダー
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    /// イニシャライザ
    public init() {
    }
    
    // MARK: - User

    /// ユーザ情報を取得する。
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - userId: ユーザの id または screen_id
    /// - Returns: TCUserInfoResponse
    public func getUserInfo(token: String, userId: String) async throws -> TCUserInfoResponse {
        
        try await TCGetUserInfoRequest(token: token, userId: userId).send()
        
    }
    
    /// アクセストークンを検証し、ユーザ情報を取得する。
    /// - Parameter token: アクセストークン
    /// - Returns: TCCredentialResponse
    public func verifyCredentials(token: String) async throws -> TCCredentialResponse {
        
        try await TCverifyCredentialsRequest(token: token).send()

    }
    
    // MARK: - Live Thumbnail

    /// 配信中のライブのサムネイル画像を取得する。
    /// - Parameters:
    ///   - userId: ユーザの id または screen_id のいずれか
    ///   - size: 画像サイズ
    ///   - position: サムネイル取得位置
    /// - Returns: サムネイル画像の Data
    public func getLiveThumbnailImage(userId: String, size: LiveThumbnailImageSize = .small, position: LiveThumbnailImagePosition = .latest) async throws -> Data {
        
        let parameter = TCGetLiveThumbnailImageRequest.Parameter(size: size, position: position)
        
        return try await TCGetLiveThumbnailImageRequest(userId: userId).send(parameter: parameter)
        
//        let url = URL(string: baseURL + "/users/\(userId)/live/thumbnail")!
//
//        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//        components.queryItems = [
//            URLQueryItem(name: "size", value: size.rawValue),
//            URLQueryItem(name: "position", value: position.rawValue)
//        ]
//
//        let request = URLRequest(url: components.url!)
//
//        let (data, response) = try await URLSession.shared.data(for: request)
//
//        guard let httpURLResponse = response as? HTTPURLResponse else {
//            throw TCError.unknownError(message: "can not cast to HTTPURLResponse")
//        }
//
//        if httpURLResponse.statusCode == 302,
//            let location = httpURLResponse.value(forHTTPHeaderField: "Location"),
//            let redirectURL = URL(string: location) {
//
//            let secondRequest = URLRequest(url: redirectURL)
//
//            let (data, _) = try await URLSession.shared.data(for: secondRequest)
//
//            return data
//
//        }
//
//        return data
        
    }
    
    // MARK: - Movie

    /// ライブ（録画）情報を取得する。
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - movieId: ライブID
    /// - Returns: TCMovieInfoResponse
    public func getMovieInfo(token: String, movieId: String) async throws -> TCMovieInfoResponse {
        
        try await TCGetMovieInfoRequest(token: token, movieId: movieId).send()
        
    }

    /// ユーザーが保有する過去ライブ（録画）の一覧を作成日時の降順で取得する。
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - userId: ユーザーID
    ///   - offset: 先頭からの位置（min:0, max:1000, default:0）
    ///   - limit: 最大取得件数(場合により、指定件数に満たない数の動画を返す可能性があります)（min:1, max:50, default:20）
    ///   - sliceId: このID以前のMovieを取得します。このパラメータを指定した場合はoffsetは無視されます。（min:1 default:none）
    /// - Returns: TCMoviesByUserResponse
    public func getMoviesByUser(token: String, userId: String, offset: Int = 0, limit: Int = 20, sliceId: String? = nil) async throws -> TCMoviesByUserResponse {
        
        let parameters = TCGetMoviesByUserRequest.Parameters(offset: offset, limit: limit, sliceId: sliceId)
        
        return try await TCGetMoviesByUserRequest(token: token, userId: userId).send(parameter: parameters)

    }

    /// ユーザーが配信中の場合、ライブ情報を取得する。
    /// - Parameters:
    ///   - token:  アクセストークン
    ///   - userId: ユーザの id または screen_id のいずれか
    /// - Returns: TCCurrentLiveResponse
    public func getCurrentLive(token: String, userId: String) async throws -> TCCurrentLiveResponse {
        
        try await TCGetCurrentLiveRequest(token: token, userId: userId).send()
        
    }

    /// ユーザーが配信中の場合、ライブのテロップを設定する。
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - subtitle: テロップ（1〜17文字）
    /// - Returns: TCCurrentLiveSubtitleResponse
    public func setCurrentLiveSubtitle(token: String, subtitle: String) async throws -> TCCurrentLiveSubtitleResponse {
        
        let parameters = TCSetCurrentLiveSubtitleRequest.Parameters(subtitle: subtitle)
        
        return try await TCSetCurrentLiveSubtitleRequest(token: token).send(parameter: parameters)
        
    }

    /// ユーザーが配信中の場合、ライブのテロップを解除する
    /// - Parameter token: アクセストークン
    /// - Returns: TCCurrentLiveSubtitleResponse
    public func unsetCurrentLiveSubtitle(token: String) async throws -> TCCurrentLiveSubtitleResponse {
        
        try await TCUnsetCurrentLiveSubtitleRequest(token: token).send()

    }

    /// ユーザーが配信中の場合、ライブのハッシュタグを設定する
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - hashtag: ハッシュタグ
    /// - Returns: TCCurrentLiveHashtagResponse
    public func setCurrentLiveHashtag(token: String, hashtag: String) async throws -> TCCurrentLiveHashtagResponse {
        
        let parameter = TCSetCurrentLiveHashtagRequest.Parameter(hashtag: hashtag)
        
        return try await TCSetCurrentLiveHashtagRequest(token: token).send(parameter: parameter)
        
    }

    /// ユーザーが配信中の場合、ライブのハッシュタグを解除する
    /// - Parameter token: アクセストークン
    /// - Returns: TCCurrentLiveHashtagResponse
    public func unsetCurrentLiveHashtag(token: String) async throws -> TCCurrentLiveHashtagResponse {
        
        try await TCUnsetCurrentLiveHashtagRequest(token: token).send()
        
    }
    
    // MARK: - Comment
    
    /// コメントを作成日時の降順で取得する
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - movieId: ライブID
    ///   - offset: 先頭からの位置
    ///   - limit: 取得件数(場合により、指定件数に満たない数のコメントを返す可能性があります)（min:1, max:50, default:10）
    ///   - sliceId: このコメントID以降のコメントを取得します。このパラメータを指定した場合はoffsetは無視されます。（min:1, default:none）
    /// - Returns: TCGetCommentsResponse
    public func getComments(token: String, movieId: String, offset: Int = 0, limit: Int = 10, sliceId: String? = nil) async throws -> TCGetCommentsResponse {
        
        let parameter = TCGetCommentsRequest.Parameter(offset: offset, limit: limit, sliceId: sliceId)
        
        return try await TCGetCommentsRequest(token: token, movieId: movieId).send(parameter: parameter)

    }

    /// コメントを投稿する。 ユーザ単位でのみ実行可能。
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - movieId: ライブID
    ///   - comment: 投稿するコメント文章（1〜140文字）
    ///   - sns: SNSへの同時投稿(ユーザーがTwitterまたはFacebookと連携しているときのみ有効)。"reply" → 配信者へリプライする形式で投稿, "normal" → 通常の投稿, "none" → SNS投稿無し
    /// - Returns: TCPostCommentResponse
    public func postComment(token: String, movieId: String, comment: String, sns: SNS = .none) async throws -> TCPostCommentResponse {
        
        let parameter = TCPostCommentRequest.Parameter(comment: comment, sns: sns)
        
        return try await TCPostCommentRequest(token: token, movieId: movieId).send(parameter: parameter)

    }

    /// コメントを削除する。 ユーザ単位でのみ実行可能です。 なお、原則として削除できるコメントは、投稿者がアクセストークンに紐づくユーザと同一のものに限られます。 ただし、Movieのオーナーであるユーザーのアクセストークンを用いる場合は他ユーザが投稿したコメントを削除することが出来ます。
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - movieId: ライブID
    ///   - commentId: コメントID
    /// - Returns: TCDeleteCommentResponse
    public func deleteComment(token: String, movieId: String, commentId: String) async throws -> TCDeleteCommentResponse {
        
        try await TCDeleteCommentRequest(token: token, movieId: movieId, commentId: commentId).send()

    }
    
    // MARK: - Gift
    
    /// アクセストークンに紐づくユーザに直近10秒程度の間に送信されたアイテムを取得する。
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - sliceId: このアイテム送信ID以降に送信されたアイテムを取得します
    /// - Returns: TCGiftsResponse
    public func getGifts(token: String, sliceId: Int = -1) async throws -> TCGiftsResponse {
        
        let parameter = TCGetGiftsRequest.Parameter(sliceId: sliceId)
        
        return try await TCGetGiftsRequest(token: token).send(parameter: parameter)
        
    }
    
    // MARK: - Supporter
    
    /// ユーザーが、ある別のユーザのサポーターであるかの状態を取得する。
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - userId: ユーザの id または screen_id のいずれか
    ///   - targetUserId: 対象ユーザの id または screen_id
    /// - Returns: TCSupportingStatusResponse
    public func getSupportingStatus(token: String, userId: String, targetUserId: String) async throws -> TCSupportingStatusResponse {
        
        let parameter = TCGetSupportingStatusRequest.Parameter(targetUserId: targetUserId)
        
        return try await TCGetSupportingStatusRequest(token: token, userId: userId).send(parameter: parameter)
        
    }
    
    /// 指定したユーザーのサポーターになる
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - targetUserIds: 対象ユーザの id または screen_id の配列（配列内の要素数 20 以下）
    /// - Returns: TCSupportUserResponse
    public func supportUser(token: String, targetUserIds: [String]) async throws -> TCSupportUserResponse {
        
        let parameter = TCSupportUserRequest.Parameter(targetUserIds: targetUserIds)
        
        return try await TCSupportUserRequest(token: token).send(parameter: parameter)
        
    }
    
    /// 指定したユーザーのサポーター状態を解除する
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - targetUserIds: 対象ユーザの id または screen_id の配列
    /// - Returns: TCUnsupportUserResponse
    public func unsupportUser(token: String, targetUserIds: [String]) async throws -> TCUnsupportUserResponse {
        
        let parameter = TCUnsupportUserRequest.Parameter(targetUserIds: targetUserIds)
        
        return try await TCUnsupportUserRequest(token: token).send(parameter: parameter)
        
    }
    
    /// 指定したユーザーがサポートしているユーザーの一覧を取得する
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - userId: ユーザの id または screen_id のいずれか
    ///   - offset: 先頭からの位置（min:0, default:0）
    ///   - limit: 取得件数（min:1, max:20, default:20）
    /// - Returns: TCSupportingListResponse
    public func supportingList(token: String, userId: String, offset: Int = 0, limit: Int = 20) async throws -> TCSupportingListResponse {
        
        let parameter = TCSupportingListRequest.Parameter(offset: offset, limit: limit)
        
        return try await TCSupportingListRequest(token: token, userId: userId).send(parameter: parameter)
        
    }

    /// 指定したユーザーをサポートしているユーザーの一覧を取得する。
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - userId: ユーザの id または screen_id のいずれか
    ///   - offset: 先頭からの位置（min:0, defalut:0）
    ///   - limit: 取得件数（min:1, max:20, default:20）
    ///   - sort: ソート順（新着順: "new", 貢献度順: "ranking"）
    /// - Returns: TCSupporterListResponse
    public func supporterList(token: String, userId: String, offset: Int = 0, limit: Int = 20, sort: SupporterSort) async throws -> TCSupporterListResponse {
        
        let parameter = TCSupporterListRequest.Parameter(offset: offset, limit: limit, sort: sort)
        
        return try await TCSupporterListRequest(token: token, userId: userId).send(parameter: parameter)
        
    }
    
    // MARK: - Category

    /// 配信中のライブがあるカテゴリのみを取得する。
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - lang: 検索対象の言語
    /// - Returns: TCCategoryResponse
    public func getCategories(token: String, lang: CategoryLang) async throws -> TCCategoryResponse {
        
        let parameter = TCGetCategoriesRequest.Parameter(lang: lang)
        
        return try await TCGetCategoriesRequest(token: token).send(parameter: parameter)

    }
    
    // MARK: - Search

    /// ユーザを検索する。
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - words: スペース区切りで複数単語のAND検索
    ///   - limit: 取得件数（min: 1, max: 50, default: 10）
    ///   - lang: 検索対象のユーザの言語設定（現在 "ja" のみ対応）
    /// - Returns: TCUsersResponse
    public func searchUsers(token: String, words: String, limit: Int = 10, lang: UsersLang = .ja) async throws -> TCUsersResponse {
        
        let parameter = TCSearchUsersRequest.Parameter(words: words, limit: limit, lang: lang)
        
        return try await TCSearchUsersRequest(token: token).send(parameter: parameter)

    }

    /// 配信中のライブを検索する。
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - limit: 取得件数（min: 1, max: 100, default: 10）
    ///   - type: 検索種別（"tag", "word", "category", "new", "recommend"）
    ///   - context: type=tag or word → スペース区切りで複数単語のAND検索. type=category → サブカテゴリID. type=new or recommend → 不要
    ///   - lang: 検索対象のライブ配信者の言語設定（現在 "ja" のみ対応）
    /// - Returns: TCLiveMoviesResponse
    public func searchLiveMovies(token: String, limit: Int = 10, type: LiveMoviesType, context: String?, lang: LiveMoviesLang = .ja) async throws -> TCLiveMoviesResponse {
        
        let parameter = TCSearchLiveMoviesRequest.Parameter(limit: limit, type: type, context: context, lang: lang)
        
        return try await TCSearchLiveMoviesRequest(token: token).send(parameter: parameter)
        
    }
    
    // MARK: - Broadcasting

    /// アクセストークンに紐づくユーザの配信用のURL(RTMP)を取得する。
    /// - Parameter token: アクセストークン
    /// - Returns: TCRTMPUrlResponse
    public func getRTMPUrl(token: String) async throws -> TCRTMPUrlResponse {
        
        try await TCGetRTMPUrlRequest(token: token).send()

    }
    
    /// アクセストークンに紐づくユーザの配信用のURL (WebM, WebSocket)を取得する。
    /// - Parameter token: アクセストークン
    /// - Returns: TCWebMUrlResponse
    public func getWebMUrl(token: String) async throws -> TCWebMUrlResponse {
        
        try await TCGetWebMUrlRequest(token: token).send()
        
    }
    
}
