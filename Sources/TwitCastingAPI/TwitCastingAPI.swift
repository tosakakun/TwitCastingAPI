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
    public enum LiveThumbnailImageSize: String {
        /// 大
        case large
        /// 小
        case small
    }
    
    /// ライブサムネイル取得位置
    public enum LiveThumbnailImagePosition: String {
        /// ライブ開始時点
        case beginning
        /// ライブ最新
        case latest
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
    public enum SupporterSort: String, CaseIterable {
        /// 新着順
        case new
        /// 貢献度順
        case ranking
    }
    
    /// カテゴリ検索対象の言語
    public enum CategoryLang: String {
        case ja
        case en
    }
    
    /// 検索対象のユーザの言語設定
    public enum UsersLang: String {
        case ja
    }
    
    /// 配信中のライブ検索の検索種別
    public enum LiveMoviesType: String, CaseIterable, Identifiable {
        case tag
        case word
        case category
        case new
        case recommend
        
        public var id: Self {
            self
        }
    }
    
    /// 配信中のライブ検索の言語設定
    public enum LiveMoviesLang: String {
        case ja
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
        
//        let url = URL(string: baseURL + "/users/" + userId)!
//
//        let request = URLRequest(url: url)
//
//        let user = try await send(token: token, request: request, type: TCUserInfoResponse.self)
//
//        return user
        
    }
    
    /// アクセストークンを検証し、ユーザ情報を取得する。
    /// - Parameter token: アクセストークン
    /// - Returns: TCCredentialResponse
    public func verifyCredentials(token: String) async throws -> TCCredentialResponse {
        
        try await TCverifyCredentialsRequest(token: token).send()
        
//        let url = URL(string: baseURL + "/verify_credentials")!
//
//        let request = URLRequest(url: url)
//
//        let credentialResponse = try await send(token: token, request: request, type: TCCredentialResponse.self)
//
//        return credentialResponse

    }
    
    // MARK: - Live Thumbnail

    /// 配信中のライブのサムネイル画像を取得する。
    /// - Parameters:
    ///   - userId: ユーザの id または screen_id のいずれか
    ///   - size: 画像サイズ
    ///   - position: サムネイル取得位置
    /// - Returns: サムネイル画像の Data
    public func getLiveThumbnailImage(userId: String, size: LiveThumbnailImageSize = .small, position: LiveThumbnailImagePosition = .latest) async throws -> Data {
        
        let url = URL(string: baseURL + "/users/\(userId)/live/thumbnail")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "size", value: size.rawValue),
            URLQueryItem(name: "position", value: position.rawValue)
        ]
        
        let request = URLRequest(url: components.url!)
        
        let (data, response) = try await URLSession.shared.data(for: request)
    
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
        
        return data
        
    }
    
    // MARK: - Movie

    /// ライブ（録画）情報を取得する。
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - movieId: ライブID
    /// - Returns: TCMovieInfoResponse
    public func getMovieInfo(token: String, movieId: String) async throws -> TCMovieInfoResponse {
        
        try await TCGetMovieInfoRequest(token: token, movieId: movieId).send()
        
//        let url = URL(string: baseURL + "/movies/\(movieId)")!
//
//        let request = URLRequest(url: url)
//
//        let movieInfoResponse = try await send(token: token, request: request, type: TCMovieInfoResponse.self)
//
//        return movieInfoResponse
        
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
        
//        let url = URL(string: baseURL + "/users/\(userId)/movies")!
//
//        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//        components.queryItems = [
//            URLQueryItem(name: "offset", value: "\(offset)"),
//            URLQueryItem(name: "limit", value: "\(limit)")
//        ]
//
//        if var validSliceId = sliceId {
//            if let intSliceId = Int(validSliceId), intSliceId < 1 {
//                validSliceId = "1"
//            }
//            components.queryItems?.append(URLQueryItem(name: "slice_id", value: validSliceId))
//        }
//
//        let request = URLRequest(url: components.url!)
//
//        let moviesByUserResponse = try await send(token: token, request: request, type: TCMoviesByUserResponse.self)
//
//        return moviesByUserResponse

    }

    /// ユーザーが配信中の場合、ライブ情報を取得する。
    /// - Parameters:
    ///   - token:  アクセストークン
    ///   - userId: ユーザの id または screen_id のいずれか
    /// - Returns: TCCurrentLiveResponse
    public func getCurrentLive(token: String, userId: String) async throws -> TCCurrentLiveResponse {
        
        try await TCGetCurrentLiveRequest(token: token, userId: userId).send()
        
//        let url = URL(string: baseURL + "/users/" + userId + "/current_live")!
//
//        let request = URLRequest(url: url)
//
//        let currentLiveResponse = try await send(token: token, request: request, type: TCCurrentLiveResponse.self)
//
//        return currentLiveResponse
        
    }

    /// ユーザーが配信中の場合、ライブのテロップを設定する。
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - subtitle: テロップ（1〜17文字）
    /// - Returns: TCCurrentLiveSubtitleResponse
    public func setCurrentLiveSubtitle(token: String, subtitle: String) async throws -> TCCurrentLiveSubtitleResponse {
        
        let parameters = TCSetCurrentLiveSubtitleRequest.Parameters(subtitle: subtitle)
        
        return try await TCSetCurrentLiveSubtitleRequest(token: token).send(parameter: parameters)
        
//        let url = URL(string: baseURL + "/movies/subtitle")!
//
//        let parameters = ["subtitle": subtitle]
//
//        guard let data = try? JSONSerialization.data(withJSONObject: parameters) else {
//            throw TCError.unknownError(message: "can not serialize parameters")
//        }
//
//        var request = URLRequest(url: url)
//        request.httpBody = data
//        request.httpMethod = HTTPMethod.post.rawValue
//
//        let currentLiveSubtitleResponse = try await send(token: token, request: request, type: TCCurrentLiveSubtitleResponse.self)
//
//        return currentLiveSubtitleResponse
        
    }

    /// ユーザーが配信中の場合、ライブのテロップを解除する
    /// - Parameter token: アクセストークン
    /// - Returns: TCCurrentLiveSubtitleResponse
    public func unsetCurrentLiveSubtitle(token: String) async throws -> TCCurrentLiveSubtitleResponse {
        
        try await TCUnsetCurrentLiveSubtitleRequest(token: token).send()
        
//        let url = URL(string: baseURL + "/movies/subtitle")!
//        var request = URLRequest(url: url)
//        request.httpMethod = HTTPMethod.delete.rawValue
//
//        let currentLiveSubtitleResponse = try await send(token: token, request: request, type: TCCurrentLiveSubtitleResponse.self)
//
//        return currentLiveSubtitleResponse

    }

    /// ユーザーが配信中の場合、ライブのハッシュタグを設定する
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - hashtag: ハッシュタグ
    /// - Returns: TCCurrentLiveHashtagResponse
    public func setCurrentLiveHashtag(token: String, hashtag: String) async throws -> TCCurrentLiveHashtagResponse {
        
        let parameter = TCSetCurrentLiveHashtagRequest.Parameter(hashtag: hashtag)
        
        return try await TCSetCurrentLiveHashtagRequest(token: token).send(parameter: parameter)
        
//        let url = URL(string: baseURL + "/movies/hashtag")!
//
//        let parameters = ["hashtag": hashtag]
//
//        guard let data = try? JSONSerialization.data(withJSONObject: parameters) else {
//            throw TCError.unknownError(message: "can not serialize parameters")
//        }
//
//        var request = URLRequest(url: url)
//        request.httpBody = data
//        request.httpMethod = HTTPMethod.post.rawValue
//
//        let currentLiveHashtagResponse = try await send(token: token, request: request, type: TCCurrentLiveHashtagResponse.self)
//
//        return currentLiveHashtagResponse
        
    }

    /// ユーザーが配信中の場合、ライブのハッシュタグを解除する
    /// - Parameter token: アクセストークン
    /// - Returns: TCCurrentLiveHashtagResponse
    public func unsetCurrentLiveHashtag(token: String) async throws -> TCCurrentLiveHashtagResponse {
        
        try await TCUnsetCurrentLiveHashtagRequest(token: token).send()
        
//        let url = URL(string: baseURL + "/movies/hashtag")!
//
//        var request = URLRequest(url: url)
//        request.httpMethod = HTTPMethod.delete.rawValue
//
//        let currentLiveHashtagResponse = try await send(token: token, request: request, type: TCCurrentLiveHashtagResponse.self)
//
//        return currentLiveHashtagResponse
        
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
        
//        let url = URL(string: baseURL + "/movies/\(movieId)/comments")!
//        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//        components.queryItems = [
//            URLQueryItem(name: "offset", value: "\(offset)"),
//            URLQueryItem(name: "limit", value: "\(limit)")
//        ]
//
//        if var validSliceId = sliceId {
//            if let intSliceId = Int(validSliceId), intSliceId < 1 {
//                validSliceId = "1"
//            }
//            components.queryItems?.append(URLQueryItem(name: "slice_id", value: validSliceId))
//        }
//
//        let request = URLRequest(url: components.url!)
//
//        let getCommentsResponse = try await send(token: token, request: request, type: TCGetCommentsResponse.self)
//
//        return getCommentsResponse

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
        
//        let url = URL(string: baseURL + "/movies/\(movieId)/comments")!
//
//        let parameters = [
//            "comment": comment,
//            "sns": sns.rawValue
//        ]
//
//        guard let data = try? JSONSerialization.data(withJSONObject: parameters) else {
//            throw TCError.unknownError(message: "can not serialize parameters")
//        }
//
//        var request = URLRequest(url: url)
//        request.httpBody = data
//        request.httpMethod = HTTPMethod.post.rawValue
//
//        let postCommentResponse = try await send(token: token, request: request, type: TCPostCommentResponse.self)
//
//        return postCommentResponse

    }

    /// コメントを削除する。 ユーザ単位でのみ実行可能です。 なお、原則として削除できるコメントは、投稿者がアクセストークンに紐づくユーザと同一のものに限られます。 ただし、Movieのオーナーであるユーザーのアクセストークンを用いる場合は他ユーザが投稿したコメントを削除することが出来ます。
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - movieId: ライブID
    ///   - commentId: コメントID
    /// - Returns: TCDeleteCommentResponse
    public func deleteComment(token: String, movieId: String, commentId: String) async throws -> TCDeleteCommentResponse {
        
        try await TCDeleteCommentRequest(token: token, movieId: movieId, commentId: commentId).send()
        
//        let url = URL(string: baseURL + "/movies/\(movieId)/comments/\(commentId)")!
//
//        var request = URLRequest(url: url)
//        request.httpMethod = HTTPMethod.delete.rawValue
//
//        let deleteCommentResponse = try await send(token: token, request: request, type: TCDeleteCommentResponse.self)
//
//        return deleteCommentResponse

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
        
//        let url = URL(string: baseURL + "/gifts")!
//
//        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//        components.queryItems = [
//            URLQueryItem(name: "slice_id", value: "\(sliceId)")
//        ]
//
//        let request = URLRequest(url: components.url!)
//
//        let giftsResponse = try await send(token: token, request: request, type: TCGiftsResponse.self)
//
//        return giftsResponse
        
    }
    
    // MARK: - Supporter
    
    /// ユーザーが、ある別のユーザのサポーターであるかの状態を取得する。
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - userId: ユーザの id または screen_id のいずれか
    ///   - targetUserId: 対象ユーザの id または screen_id
    /// - Returns: TCSupportingStatusResponse
    public func getSupportingStatus(token: String, userId: String, targetUserId: String) async throws -> TCSupportingStatusResponse {
        
        let url = URL(string: baseURL + "/users/\(userId)/supporting_status")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "target_user_id", value: targetUserId)
        ]
        
        let request = URLRequest(url: components.url!)
        
        let supportingStatusResponse = try await send(token: token, request: request, type: TCSupportingStatusResponse.self)
        
        return supportingStatusResponse
        
    }
    
    /// 指定したユーザーのサポーターになる
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - targetUserIds: 対象ユーザの id または screen_id の配列（配列内の要素数 20 以下）
    /// - Returns: TCSupportUserResponse
    public func supportUser(token: String, targetUserIds: [String]) async throws -> TCSupportUserResponse {
        
        let url = URL(string: baseURL + "/support")!
        
        let parameters = ["target_user_ids": targetUserIds]
        
        guard let data = try? JSONSerialization.data(withJSONObject: parameters) else {
            throw TCError.unknownError(message: "can not serialize parameters")
        }
        
        var request = URLRequest(url: url)
        request.httpBody = data
        request.httpMethod = HTTPMethod.put.rawValue
        
        let supportUserResponse = try await send(token: token, request: request, type: TCSupportUserResponse.self)
        
        return supportUserResponse
        
    }
    
    /// 指定したユーザーのサポーター状態を解除する
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - targetUserIds: 対象ユーザの id または screen_id の配列
    /// - Returns: TCUnsupportUserResponse
    public func unsupportUser(token: String, targetUserIds: [String]) async throws -> TCUnsupportUserResponse {
        
        let url = URL(string: baseURL + "/unsupport")!
        
        let parameters = ["target_user_ids": targetUserIds]
        
        guard let data = try? JSONSerialization.data(withJSONObject: parameters) else {
            throw TCError.unknownError(message: "can not serialize parameters")
        }
        
        var request = URLRequest(url: url)
        request.httpBody = data
        request.httpMethod = HTTPMethod.put.rawValue
        
        let unsupportUserResponse = try await send(token: token, request: request, type: TCUnsupportUserResponse.self)
        
        return unsupportUserResponse
        
    }
    
    /// 指定したユーザーがサポートしているユーザーの一覧を取得する
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - userId: ユーザの id または screen_id のいずれか
    ///   - offset: 先頭からの位置（min:0, default:0）
    ///   - limit: 取得件数（min:1, max:20, default:20）
    /// - Returns: TCSupportingListResponse
    public func supportingList(token: String, userId: String, offset: Int = 0, limit: Int = 20) async throws -> TCSupportingListResponse {
        
        let url = URL(string: baseURL + "/users/\(userId)/supporting")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "limit", value: "\(limit)")
        ]
        
        let request = URLRequest(url: components.url!)
        
        let supportingListResponse = try await send(token: token, request: request, type: TCSupportingListResponse.self)
        
        return supportingListResponse
        
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
        
        let url = URL(string: baseURL + "/users/\(userId)/supporters")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "sort", value: sort.rawValue)
        ]
        
        let request = URLRequest(url: components.url!)
        
        let supporterListResponse = try await send(token: token, request: request, type: TCSupporterListResponse.self)
        
        return supporterListResponse
        
    }
    
    // MARK: - Category

    /// 配信中のライブがあるカテゴリのみを取得する。
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - lang: 検索対象の言語
    /// - Returns: TCCategoryResponse
    public func getCategories(token: String, lang: CategoryLang) async throws -> TCCategoryResponse {
        
        let url = URL(string: baseURL + "/categories")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "lang", value: lang.rawValue)
        ]
        
        let request = URLRequest(url: components.url!)
        
        let categoryResponse = try await send(token: token, request: request, type: TCCategoryResponse.self)
        
        return categoryResponse

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
        
        let url = URL(string: baseURL + "/search/users")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "words", value: words),
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "lang", value: lang.rawValue)
        ]
        
        let request = URLRequest(url: components.url!)
        
        let usersResponse = try await send(token: token, request: request, type: TCUsersResponse.self)
        
        return usersResponse

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
        
        let url = URL(string: baseURL + "/search/lives")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "type", value: type.rawValue),
            URLQueryItem(name: "lang", value: lang.rawValue)
        ]
        
        
        if type == .tag || type == .word || type == .category {
            components.queryItems?.append(URLQueryItem(name: "context", value: context))
        }
        
        let request = URLRequest(url: components.url!)
        
        let liveMoviesResponse = try await send(token: token, request: request, type: TCLiveMoviesResponse.self)
        
        return liveMoviesResponse
        
    }
    
    // MARK: - WebHook

    /// アプリケーションに紐づく WebHook の一覧を取得する。アプリケーション単位でのみ実行可能です。
    /// - Parameters:
    ///   - clientId: クライアントID
    ///   - clientSecret: クライアントシークレット
    ///   - limit: 取得件数（userId の指定がない場合のみ有効）
    ///   - offset: 先頭からの位置（userId の指定がない場合のみ有効）
    ///   - userId: 対象ユーザのID
    /// - Returns: TCWebHookListResponse
    public func getWebHook(clientId: String, clientSecret: String, limit: Int = 50, offset: Int = 0, userId: String? = nil) async throws -> TCWebHookListResponse {
        
        let url = URL(string: baseURL + "/webhooks")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        if let userId = userId {
            components.queryItems = [
                URLQueryItem(name: "user_id", value: userId)
            ]
        } else {
            components.queryItems = [
                URLQueryItem(name: "limit", value: "\(limit)"),
                URLQueryItem(name: "offset", value: "\(offset)")
            ]
        }
        
        let request = URLRequest(url: components.url!)
        
        let webhookResponse = try await send(clientId: clientId, clientSecret: clientSecret, request: request, type: TCWebHookListResponse.self)
        
        return webhookResponse
        
    }

    /// WebHookを新規登録します。このAPIを使用するためには、アプリケーションに WebHook URL が登録されている必要があります。
    /// - Parameters:
    ///   - clientId: クライアントID
    ///   - clientSecret: クライアントシークレット
    ///   - userId: ユーザID
    ///   - events: フックするイベント種別(ライブ開始:"livestart", ライブ終了:"liveend")の配列
    /// - Returns: TCRegisterWebHookResponse
    public func registerWebHook(clientId: String, clientSecret: String, userId: String, events: [WebHookEvent]) async throws -> TCRegisterWebHookResponse {
        
        let url = URL(string: baseURL + "/webhooks")!
        
        // events の重複を削除
        var eventsArray = events.map { $0.rawValue }
        eventsArray = Array(Set(eventsArray))
        
        let parameters: [String : Any] = [
            "user_id": userId,
            "events": eventsArray
        ]
        
        guard let data = try? JSONSerialization.data(withJSONObject: parameters) else {
            throw TCError.unknownError(message: "can not serialize parameters")
        }
        
        var request = URLRequest(url: url)
        request.httpBody = data
        request.httpMethod = HTTPMethod.post.rawValue
        
        let registerWebHookResponse = try await send(clientId: clientId, clientSecret: clientSecret, request: request, type: TCRegisterWebHookResponse.self)
        
        return registerWebHookResponse
        
    }
    
    
    /// WebHookを削除する。
    /// - Parameters:
    ///   - clientId: クライアントID
    ///   - clientSecret: クライアントシークレット
    ///   - userId: ユーザID
    ///   - events: フックを削除するイベント種別(ライブ開始:"livestart", ライブ終了:"liveend")の配列
    /// - Returns: TCRemoveWebHookResponse
    public func removeWebHook(clientId: String, clientSecret: String, userId: String, events: [WebHookEvent]) async throws -> TCRemoveWebHookResponse {
        
        let url = URL(string: baseURL + "/webhooks")!
        
        // events の重複を削除
        var eventsArray = events.map { $0.rawValue }
        eventsArray = Array(Set(eventsArray))
        
        let parameters: [String : Any] = [
            "user_id": userId,
            "events": eventsArray
        ]
        
        guard let data = try? JSONSerialization.data(withJSONObject: parameters) else {
            throw TCError.unknownError(message: "can not serialize parameters")
        }
        
        var request = URLRequest(url: url)
        request.httpBody = data
        request.httpMethod = HTTPMethod.delete.rawValue
        
        let removeWebHookResponse = try await send(clientId: clientId, clientSecret: clientSecret, request: request, type: TCRemoveWebHookResponse.self)
        
        return removeWebHookResponse
        
    }
    
    // MARK: - Broadcasting

    /// アクセストークンに紐づくユーザの配信用のURL(RTMP)を取得する。
    /// - Parameter token: アクセストークン
    /// - Returns: TCRTMPUrlResponse
    public func getRTMPUrl(token: String) async throws -> TCRTMPUrlResponse {
        
        let url = URL(string: baseURL + "/rtmp_url")!
        
        let request = URLRequest(url: url)
        
        let rtmpUrlResponse = try await send(token: token, request: request, type: TCRTMPUrlResponse.self)
        
        return rtmpUrlResponse

    }
    
    /// アクセストークンに紐づくユーザの配信用のURL (WebM, WebSocket)を取得する。
    /// - Parameter token: アクセストークン
    /// - Returns: TCWebMUrlResponse
    public func getWebMUrl(token: String) async throws -> TCWebMUrlResponse {
        
        let url = URL(string: baseURL + "/webm_url")!
        
        let request = URLRequest(url: url)
        
        let webMUrlResponse = try await send(token: token, request: request, type: TCWebMUrlResponse.self)
        
        return webMUrlResponse
        
    }
    
    // MARK: - Private Method
    
    /// リクエストを送信する
    /// - Parameters:
    ///   - token: アクセストークン
    ///   - request: リクエスト
    ///   - type: レスポンスの型
    /// - Returns: レスポンスオブジェクト
    private func send<T: Codable>(token: String, request: URLRequest, type: T.Type) async throws -> T {
        
        // リクエストヘッダの設定
        var request = request
        request.addValue("2.0", forHTTPHeaderField: "X-Api-Version")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        return try await send(request: request, type: type)
        
    }

    /// リクエストを送信する
    /// - Parameters:
    ///   - clientId: クライアントID
    ///   - clientSecret: クライアントシークレット
    ///   - request: リクエスト
    ///   - type: レスポンスの型
    /// - Returns: レスポンスオブジェクト
    private func send<T: Codable>(clientId: String, clientSecret: String, request: URLRequest, type: T.Type) async throws -> T {
        
        let client = "\(clientId):\(clientSecret)"
        
        guard let clientData = client.data(using: .utf8) else {
            throw TCError.unknownError(message: "can not convert clientId and clientSecret into data.")
        }
        
        let encodeString = clientData.base64EncodedString()
        
        var request = request
        request.addValue("2.0", forHTTPHeaderField: "X-Api-Version")
        request.addValue("Basic \(encodeString)", forHTTPHeaderField: "Authorization")
        
        return try await send(request: request, type: type)

    }
    
    /// リクエストを送信する
    /// - Parameters:
    ///   - request: リクエスト
    ///   - type: レスポンスの型
    /// - Returns: レスポンスオブジェクト
    private func send<T: Codable>(request: URLRequest, type: T.Type) async throws -> T {
        
        // リクエストを送信
        let (data, response) = try await URLSession.shared.data(for: request)
        
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
        guard let object = try? decoder.decode(type, from: data) else {
            throw TCError.unknownError(message: "can not decode response")
        }
            
        return object
        
    }
    
}
