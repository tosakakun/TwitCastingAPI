//
//  TwitCastingAPITests.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/06/01.
//
import Foundation
import XCTest
@testable import TwitCastingAPI

final class TwitCastingAPITests: XCTestCase {
    
    override func setUp() async throws {
        try await super.setUp()
        URLProtocol.registerClass(MockURLProtocol.self)
    }
    
    override func tearDown() async throws {
        URLProtocol.unregisterClass(MockURLProtocol.self)
        try await super.tearDown()
    }
    
    private func setMockData(fileName: String, statusCode: Int = 200) {
        
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
    
    func testGetUserInfo() async throws {
        
        setMockData(fileName: "GetUserInfo")
        
        let request = TCGetUserInfoRequest(token: "token", userId: "twitcasting_jp")
        let response = try await request.send()
        
        XCTAssertEqual(response.user.id, "182224938")
        XCTAssertEqual(response.supporterCount, 10)
        
    }
    
    func testVerifyCredentials() async throws {
        
        setMockData(fileName: "VerifyCredentials")
        
        let request = TCVerifyCredentialsRequest(token: "token")
        let response = try await request.send()
        
        XCTAssertEqual(response.app.clientId, "182224938.d37f58350925d568e2db24719fe86f11c4d14e0461429e8b5da732fcb1917b6e")
        XCTAssertEqual(response.user.id, "182224938")
        XCTAssertEqual(response.supportingCount, 24)

    }
    
    func testGetMovieInfo() async throws {
        
        setMockData(fileName: "GetMovieInfo")
        
        let movieId = "189037369"
        
        let request = TCGetMovieInfoRequest(token: "token", movieId: movieId)
        let response = try await request.send()
        
        XCTAssertEqual(response.movie.id, movieId)
        XCTAssertEqual(response.broadcaster.id, "182224938")
        XCTAssertEqual(response.tags, ["人気", "コンティニュー中", "レベル40+", "初見さん大歓迎", "まったり", "雑談"])
    }
    
    func testGetMoviesbyUser() async throws {
        
        setMockData(fileName: "GetMoviesbyUser")
        
        let request = TCGetMoviesByUserRequest(token: "token", userId: "twitcasting_jp")
        let response = try await request.send()
        
        XCTAssertEqual(response.totalCount, 5)
        XCTAssertEqual(response.movies.count, 2)
        XCTAssertEqual(response.movies[0].id, "323387579")
        XCTAssertEqual(response.movies[1].id, "189037369")
        
    }
    
    func testGetCurrentLive() async throws {
        
        setMockData(fileName: "GetCurrentLive")
        
        let request = TCGetCurrentLiveRequest(token: "token", userId: "twitcasting_jp")
        let response = try await request.send()
        
        XCTAssertEqual(response.movie.id, "189037369")
        XCTAssertEqual(response.broadcaster.id, "182224938")
        XCTAssertEqual(response.tags, ["人気", "コンティニュー中", "レベル40+", "初見さん大歓迎", "まったり", "雑談"])
        
    }
    
    func testSetCurrentLiveSubtitle() async throws {
        
        setMockData(fileName: "SetCurrentLiveSubtitle")
        
        let request = TCSetCurrentLiveSubtitleRequest(token: "token")
        let parameter = TCSetCurrentLiveSubtitleRequest.Parameters(subtitle: "初見さん大歓迎！")
        let response = try await request.send(parameter: parameter)
        
        XCTAssertEqual(response.movieId, "323387579")
        XCTAssertEqual(response.subtitle, "初見さん大歓迎！")
        
    }
    
    func testUnsetCurrentLiveSubtitle() async throws {
        
        setMockData(fileName: "UnsetCurrentLiveSubtitle")
        
        let request = TCUnsetCurrentLiveSubtitleRequest(token: "token")
        let response = try await request.send()
        
        XCTAssertEqual(response.movieId, "323387579")
        XCTAssertNil(response.subtitle)
        
    }
    
    func testSetCurrentLiveHashtag() async throws {
        
        setMockData(fileName: "SetCurrentLiveHashtag")
        
        let request = TCSetCurrentLiveHashtagRequest(token: "token")
        let parameter = TCSetCurrentLiveHashtagRequest.Parameter(hashtag: "#初見さん大歓迎")
        let response = try await request.send(parameter: parameter)
        
        XCTAssertEqual(response.movieId, "323387579")
        XCTAssertEqual(response.hashtag, "#初見さん大歓迎")
        
    }
    
    func testUnsetCurrentLiveHashtag() async throws {
        
        setMockData(fileName: "UnsetCurrentLiveHashtag")
        
        let request = TCUnsetCurrentLiveHashtagRequest(token: "token")
        let response = try await request.send()
        
        XCTAssertEqual(response.movieId, "323387579")
        XCTAssertNil(response.hashtag)
        
    }
    
    func testGetComments() async throws {
        
        setMockData(fileName: "GetComments")
        
        let movieId = "189037369"
        
        let request = TCGetCommentsRequest(token: "token", movieId: movieId)
        let parameter = TCGetCommentsRequest.Parameter(offset: 10, limit: 10, sliceId: nil)
        let response = try await request.send(parameter: parameter)
        
        XCTAssertEqual(response.movieId, movieId)
        XCTAssertEqual(response.allCount, 2124)
        XCTAssertEqual(response.comments.count, 1)
        XCTAssertEqual(response.comments[0].id, "7134775954")
        XCTAssertEqual(response.comments[0].fromUser.id, "182224938")
        XCTAssertEqual(response.comments[0].created, 1479579471)
        
    }

    func testPostComment() async throws {
        
        setMockData(fileName: "PostComment")
        
        let movieId = "189037369"
        
        let request = TCPostCommentRequest(token: "token", movieId: movieId)
        let parameter = TCPostCommentRequest.Parameter(comment: "モイ！", sns: .none)
        let response = try await request.send(parameter: parameter)
        
        XCTAssertEqual(response.movieId, movieId)
        XCTAssertEqual(response.allCount, 2124)
        XCTAssertEqual(response.comment.id, "7134775954")
        XCTAssertEqual(response.comment.message, "モイ！")
        XCTAssertEqual(response.comment.fromUser.id, "182224938")
        XCTAssertEqual(response.comment.created, 1479579471)
        
    }
    
    func testDeleteComment() async throws {
        
        setMockData(fileName: "DeleteComment")
        
        let movieId = "189037369"
        let commentId = "123456"
        
        let request = TCDeleteCommentRequest(token: "token", movieId: movieId, commentId: commentId)
        let response = try await request.send()
        
        XCTAssertEqual(response.commentId, commentId)
        
    }
    
    func testGetGifts() async throws {
        
        setMockData(fileName: "GetGifts")
        
        let request = TCGetGiftsRequest(token: "token")
        let parameter = TCGetGiftsRequest.Parameter(sliceId: 2124)
        let response = try await request.send(parameter: parameter)
        
        XCTAssertEqual(response.sliceId, 2124)
        XCTAssertEqual(response.gifts.count, 1)
        // https://apiv2-doc.twitcasting.tv/#get-gifts の Sample Response の例と異なり
        // gifts[0].id は、実際は整数型で戻って来ている
        XCTAssertEqual(response.gifts[0].id, 2125)
        XCTAssertEqual(response.gifts[0].message, "モイ！")
        XCTAssertEqual(response.gifts[0].itemId, "tea")
        // https://apiv2-doc.twitcasting.tv/#get-gifts の Sample Response の例と異なり
        // gifts[0].itemId は、実際は整数型で戻って来ている
        XCTAssertEqual(response.gifts[0].itemMp, 10)
        
    }
    
    func testGetSupportingStatus() async throws {
        
        setMockData(fileName: "GetSupportingStatus")
        
        let targetId = "casma_jp"
        
        let request = TCGetSupportingStatusRequest(token: "token", userId: "twitcasting_dev")
        let parameter = TCGetSupportingStatusRequest.Parameter(targetUserId: targetId)
        let response = try await request.send(parameter: parameter)
        
        XCTAssertEqual(response.isSupporting, true)
        XCTAssertEqual(response.supported, 1632716873)
        XCTAssertEqual(response.targetUser.screenId, targetId)

    }
    
    func testSupportUser() async throws {
        
        setMockData(fileName: "SupportUser")
        
        let request = TCSupportUserRequest(token: "token")
        let parameter = TCSupportUserRequest.Parameter(targetUserIds: ["casma_jp", "twitcasting_pr"])
        let response = try await request.send(parameter: parameter)
        
        XCTAssertEqual(response.addedCount, 2)
        
    }
    
    func testUnsupportUser() async throws {
        
        setMockData(fileName: "UnsupportUser")
        
        let request = TCUnsupportUserRequest(token: "token")
        let parameter = TCUnsupportUserRequest.Parameter(targetUserIds: ["casma_jp", "twitcasting_pr"])
        let response = try await request.send(parameter: parameter)
        
        XCTAssertEqual(response.removedCount, 2)
        
    }
    
    func testSupportingList() async throws {
        
        setMockData(fileName: "SupportingList")
        
        let request = TCSupportingListRequest(token: "token", userId: "twitcasting_dev")
        let parameter = TCSupportingListRequest.Parameter(offset: 10, limit: 20)
        let response = try await request.send(parameter: parameter)
        
        XCTAssertEqual(response.total, 1234)
        XCTAssertEqual(response.supporting.count, 2)
        XCTAssertEqual(response.supporting[0].id, "182224938")
        XCTAssertEqual(response.supporting[0].screenId, "twitcasting_jp")
        XCTAssertEqual(response.supporting[1].id, "2880417757")
        XCTAssertEqual(response.supporting[1].screenId, "twitcasting_pr")

    }
    
    func testSupporterList() async throws {
        
        setMockData(fileName: "SupporterList")
        
        let request = TCSupporterListRequest(token: "token", userId: "twitcasting_dev")
        let parameter = TCSupporterListRequest.Parameter(offset: 10, limit: 20, sort: .ranking)
        let response = try await request.send(parameter: parameter)
        
        XCTAssertEqual(response.total, 1234)
        XCTAssertEqual(response.supporters.count, 2)
        XCTAssertEqual(response.supporters[0].id, "182224938")
        XCTAssertEqual(response.supporters[0].name, "ツイキャス公式")
        XCTAssertEqual(response.supporters[0].image, "http://202-234-44-53.moi.st/image3s/pbs.twimg.com/profile_images/613625726512705536/GLlBoXcS_normal.png")
        XCTAssertEqual(response.supporters[1].id, "2880417757")
        XCTAssertEqual(response.supporters[1].name, "ツイキャス運営事務局")
        XCTAssertEqual(response.supporters[1].image, "http://202-234-44-61.moi.st/image3s/pbs.twimg.com/profile_images/740857980137050112/4sIEkzV8_normal.jpg")
        
    }
    
    func testGetCategories() async throws {
        
        setMockData(fileName: "GetCategories")
        
        let request = TCGetCategoriesRequest(token: "token")
        let parameter = TCGetCategoriesRequest.Parameter(lang: .ja)
        let response = try await request.send(parameter: parameter)
        
        XCTAssertEqual(response.categories.count, 2)
        XCTAssertEqual(response.categories[0].id, "_channel")
        XCTAssertEqual(response.categories[0].subCategories.count, 3)
        XCTAssertEqual(response.categories[0].subCategories[0].id, "_system_channel_5")
        XCTAssertEqual(response.categories[0].subCategories[0].count, 100)
        XCTAssertEqual(response.categories[1].id, "girls_jp")
        XCTAssertEqual(response.categories[1].subCategories.count, 3)
        XCTAssertEqual(response.categories[1].subCategories[0].id, "girls_face_jp")
        XCTAssertEqual(response.categories[1].subCategories[0].count, 66)

    }
    
    func testSearchUsers() async throws {
        
        setMockData(fileName: "SearchUsers")
        
        let request = TCSearchUsersRequest(token: "token")
        let parameter = TCSearchUsersRequest.Parameter(words: "ツイキャス 公式", limit: 10, lang: .ja)
        let response = try await request.send(parameter: parameter)
        
        XCTAssertEqual(response.users.count, 2)
        XCTAssertEqual(response.users[0].id, "182224938")
        XCTAssertEqual(response.users[0].profile, "ツイキャスの公式アカウントです。ツイキャスに関するお知らせなどを投稿します。なお、お問い合わせは https://t.co/4gCf7XVm7N までお願いします。公式Facebookページhttps://t.co/bxYVwpzTJB\n公式Instagram\nhttps://t.co/Bm2O2J2Kfs")
        XCTAssertEqual(response.users[0].level, 24)
        XCTAssertEqual(response.users[1].id, "2880417757")
        XCTAssertEqual(response.users[1].profile, "モイ！ ツイキャスを運営しているモイ株式会社広報担当のアカウントです。公式アカウントはこちら！　@twitcasting_jp")
        XCTAssertEqual(response.users[1].level, 24)

    }
    
    func testSearchLiveMovies() async throws {
        
        setMockData(fileName: "SearchLiveMovies")
        
        let request = TCSearchLiveMoviesRequest(token: "token")
        let parameter = TCSearchLiveMoviesRequest.Parameter(limit: 10, type: .recommend, context: nil, lang: .ja)
        let response = try await request.send(parameter: parameter)
        
        XCTAssertEqual(response.movies.count, 2)
        XCTAssertEqual(response.movies[0].movie.id, "189037369")
        XCTAssertEqual(response.movies[0].movie.userId, "182224938")
        XCTAssertEqual(response.movies[0].broadcaster.id, "182224938")
        XCTAssertTrue(response.movies[0].broadcaster.isLive)
        XCTAssertEqual(response.movies[0].tags, ["人気", "コンティニュー中", "レベル40+", "初見さん大歓迎", "まったり", "雑談"])
        
        XCTAssertEqual(response.movies[1].movie.id, "323387579")
        XCTAssertEqual(response.movies[1].movie.userId, "2880417757")
        XCTAssertEqual(response.movies[1].broadcaster.id, "2880417757")
        XCTAssertTrue(response.movies[1].broadcaster.isLive)
        XCTAssertEqual(response.movies[1].tags, ["人気", "コンティニュー中", "レベル40+", "初見さん大歓迎", "まったり", "雑談"])
        
    }
    
    func testGetRTMPUrl() async throws {
        
        setMockData(fileName: "GetRTMPUrl")
        
        let request = TCGetRTMPUrlRequest(token: "token")
        let response = try await request.send()
        
        XCTAssertTrue(response.enabled)
        XCTAssertEqual(response.url, "rtmp://rtmp02.twitcasting.tv/publish_tool/twitcasting_jp?user=twitcasting_jp&key=this_is_secret_key&client_type=public_api&is_publisher_tool=1")
        XCTAssertEqual(response.streamKey, "twitcasting_jp")
        
    }
    
    func testGetWebMUrl() async throws {
        
        setMockData(fileName: "GetWebMUrl")
        
        let request = TCGetWebMUrlRequest(token: "token")
        let response = try await request.send()
        
        XCTAssertTrue(response.enabled)
        XCTAssertEqual(response.url, "wss://webm01.twitcasting.tv/ws.app/reader/webm?user_id=twitcasting_jp&key=this_is_secret_key&client_type=public_api")
        
    }
    
    func testInvalidToken() async throws {
        
        setMockData(fileName: "InvalidToken", statusCode: 401)
        
        let request = TCGetUserInfoRequest(token: "token", userId: "twitcasting_jp")
        
        do {
            let _ = try await request.send()
            XCTAssertThrowsError("No error occurred")
        } catch let error as TCError {
            
            switch error {
            case .invalidToken(let code, let message):
                XCTAssertEqual(code, 1000)
                XCTAssertEqual(message, "Invalid token")
            default:
                XCTAssertThrowsError("Invalid Error Type")
            }
            
        }
        
    }
    
    func testValidationError() async throws {
        
        setMockData(fileName: "ValidationError", statusCode: 400)
        
        let movieId = "189037369"
        
        let request = TCGetCommentsRequest(token: "token", movieId: movieId)
        let parameter = TCGetCommentsRequest.Parameter(offset: 10, limit: 10, sliceId: nil)
        
        do {
            let _ = try await request.send(parameter: parameter)
            
        } catch let error as TCError {
            
            switch error {
            case .validationError(let code, let message, let details):
                XCTAssertEqual(code, 1001)
                XCTAssertEqual(message, "Validation error")
                XCTAssertEqual(details, ["limit": ["intVal"], "offset": ["min"]])
            default:
                XCTAssertThrowsError("Invalid Error Type")
            }
            
        }
        
    }
    
    func testExecutionCountLimitation() async throws {
        
        setMockData(fileName: "ExecutionCountLimitation", statusCode: 403)
        
        let request = TCGetUserInfoRequest(token: "token", userId: "twitcasting_jp")
        
        do {
            let _ = try await request.send()
            XCTAssertThrowsError("No error occurred")
        } catch let error as TCError {
            
            switch error {
            case .executionCountLimitation(let code, let message):
                XCTAssertEqual(code, 2000)
                XCTAssertEqual(message, "Execution count limitation")
            default:
                XCTAssertThrowsError("Invalid Error Type")
            }
            
        }
        
    }
    
    func testApplicationDisabled() async throws {
        
        setMockData(fileName: "ApplicationDisabled", statusCode: 403)
        
        let request = TCGetUserInfoRequest(token: "token", userId: "twitcasting_jp")
        
        do {
            let _ = try await request.send()
            XCTAssertThrowsError("No error occurred")
        } catch let error as TCError {
            
            switch error {
            case .applicationDisabled(let code, let message):
                XCTAssertEqual(code, 2001)
                XCTAssertEqual(message, "Application is disabled")
            default:
                XCTAssertThrowsError("Invalid Error Type")
            }
            
        }

    }
    
    func testProtected() async throws {
        
        setMockData(fileName: "Protected", statusCode: 403)
        
        let movieId = "189037369"
        
        let request = TCPostCommentRequest(token: "token", movieId: movieId)
        let parameter = TCPostCommentRequest.Parameter(comment: "モイ！", sns: .none)
        
        do {
            let _ = try await request.send(parameter: parameter)
            XCTAssertThrowsError("No error occurred")
        } catch let error as TCError {
            
            switch error {
            case .protected(let code, let message):
                XCTAssertEqual(code, 2002)
                XCTAssertEqual(message, "Protected")
            default:
                XCTAssertThrowsError("Invalid Error Type")
            }
            
        }
        
    }
    
    func testDuplicate() async throws {
        
        setMockData(fileName: "Duplicate", statusCode: 403)
        
        let movieId = "189037369"
        
        let request = TCPostCommentRequest(token: "token", movieId: movieId)
        let parameter = TCPostCommentRequest.Parameter(comment: "モイ！", sns: .none)
        
        do {
            let _ = try await request.send(parameter: parameter)
            XCTAssertThrowsError("No error occurred")
        } catch let error as TCError {
            
            switch error {
            case .duplicate(let code, let message):
                XCTAssertEqual(code, 2003)
                XCTAssertEqual(message, "Duplicate")
            default:
                XCTAssertThrowsError("Invalid Error Type")
            }
            
        }

    }
    
    func testTooManyComments() async throws {
        
        setMockData(fileName: "TooManyComments", statusCode: 403)
        
        let movieId = "189037369"
        
        let request = TCPostCommentRequest(token: "token", movieId: movieId)
        let parameter = TCPostCommentRequest.Parameter(comment: "モイ！", sns: .none)
        
        do {
            let _ = try await request.send(parameter: parameter)
            XCTAssertThrowsError("No error occurred")
        } catch let error as TCError {
            
            switch error {
            case .tooManyComments(let code, let message):
                XCTAssertEqual(code, 2004)
                XCTAssertEqual(message, "Too many comments")
            default:
                XCTAssertThrowsError("Invalid Error Type")
            }
            
        }

    }
    
    func testOutOfScope() async throws {
        
        setMockData(fileName: "OutOfScope", statusCode: 403)
        
        let movieId = "189037369"
        let commentId = "123456"
        
        let request = TCDeleteCommentRequest(token: "token", movieId: movieId, commentId: commentId)
        
        do {
            
            let _ = try await request.send()
            XCTAssertThrowsError("No error occurred")
            
        } catch let error as TCError {
            
            switch error {
            case .outOfScope(let code, let message):
                XCTAssertEqual(code, 2005)
                XCTAssertEqual(message, "Out of scope")
            default:
                XCTAssertThrowsError("Invalid Error Type")
            }
            
        }
        
    }
    
    func testEmailUnverified() async throws {
        
        setMockData(fileName: "EmailUnverified", statusCode: 403)
        
        let request = TCGetRTMPUrlRequest(token: "token")
        
        do {
            let _ = try await request.send()
            XCTAssertThrowsError("No error occurred")
        } catch let error as TCError {
            
            switch error {
            case .emailUnverified(let code, let message):
                XCTAssertEqual(code, 2006)
                XCTAssertEqual(message, "Email is not verified")
            default:
                XCTAssertThrowsError("Invalid Error Type")
            }
            
        }
    }
    
    func testBadRequest() async throws {
        
        setMockData(fileName: "BadRequest", statusCode: 400)
        
        let targetId = "casma_jp"
        
        let request = TCGetSupportingStatusRequest(token: "token", userId: "twitcasting_dev")
        let parameter = TCGetSupportingStatusRequest.Parameter(targetUserId: targetId)
        
        do {
            let _ = try await request.send(parameter: parameter)
            XCTAssertThrowsError("No error occurred")
        } catch let error as TCError {
            
            switch error {
            case .badRequest(let code, let message):
                XCTAssertEqual(code, 400)
                XCTAssertEqual(message, "Bad Request")
            default:
                XCTAssertThrowsError("Invalid Error Type")
            }
            
        }
    }

}
