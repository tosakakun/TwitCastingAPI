//
//  TwitCastingAPITests.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/06/01.
//
import Foundation
import XCTest
@testable import TwitCastingAPI

final class TwitCastingAPITests: TwitCastingAPITestCase {
    
    func testGetUserInfo() async throws {
        
        setMockData(fileName: "GetUserInfo")
        
        let request = TCGetUserInfoRequest(token: "token", userId: "twitcasting_jp")
        let response = try await request.send()
        
        XCTAssertEqual(response.user.id, "182224938")
        XCTAssertEqual(response.user.screenId, "twitcasting_jp")
        XCTAssertEqual(response.user.name, "ツイキャス公式")
        XCTAssertEqual(response.user.image, "http://202-234-44-53.moi.st/image3s/pbs.twimg.com/profile_images/613625726512705536/GLlBoXcS_normal.png")
        XCTAssertEqual(response.user.profile, "ツイキャスの公式アカウントです。ツイキャスに関するお知らせなどを投稿します。なお、お問い合わせは https://t.co/4gCf7XVm7N までお願いします。公式Facebookページhttps://t.co/bxYVwpzTJB\n公式Instagram\nhttps://t.co/Bm2O2J2Kfs")
        XCTAssertEqual(response.user.level, 24)
        XCTAssertEqual(response.user.lastMovieId, "189037369")
        XCTAssertFalse(response.user.isLive)
        XCTAssertEqual(response.supporterCount, 10)
        XCTAssertEqual(response.supportingCount, 24)
        
    }
    
    func testVerifyCredentials() async throws {
        
        setMockData(fileName: "VerifyCredentials")
        
        let request = TCVerifyCredentialsRequest(token: "token")
        let response = try await request.send()
        
        XCTAssertEqual(response.app.clientId, "182224938.d37f58350925d568e2db24719fe86f11c4d14e0461429e8b5da732fcb1917b6e")
        XCTAssertEqual(response.app.name, "サンプルアプリケーション")
        XCTAssertEqual(response.app.ownerUserId, "182224938")
        XCTAssertEqual(response.user.id, "182224938")
        XCTAssertEqual(response.supporterCount, 10)
        XCTAssertEqual(response.supportingCount, 24)

    }
    
    func testGetMovieInfo() async throws {
        
        setMockData(fileName: "GetMovieInfo")
        
        let movieId = "189037369"
        
        let request = TCGetMovieInfoRequest(token: "token", movieId: movieId)
        let response = try await request.send()
        
        XCTAssertEqual(response.movie.id, movieId)
        XCTAssertEqual(response.movie.userId, "182224938")
        XCTAssertEqual(response.movie.title, "ライブ #189037369")
        XCTAssertEqual(response.movie.subtitle, "ライブ配信中！")
        XCTAssertEqual(response.movie.lastOwnerComment, "もいもい")
        XCTAssertEqual(response.movie.category, "girls_jcjk_jp")
        XCTAssertEqual(response.movie.link, "http://twitcasting.tv/twitcasting_jp/movie/189037369")
        XCTAssertFalse(response.movie.isLive)
        XCTAssertFalse(response.movie.isRecorded)
        XCTAssertEqual(response.movie.commentCount, 2124)
        XCTAssertEqual(response.movie.largeThumbnail, "http://202-230-12-92.twitcasting.tv/image3/image.twitcasting.tv/image55_1/39/7b/0b447b39-1.jpg")
        XCTAssertEqual(response.movie.smallThumbnail, "http://202-230-12-92.twitcasting.tv/image3/image.twitcasting.tv/image55_1/39/7b/0b447b39-1-s.jpg")
        XCTAssertEqual(response.movie.country, "jp")
        XCTAssertEqual(response.movie.duration, 1186)
        XCTAssertEqual(response.movie.created, 1438500282)
        XCTAssertFalse(response.movie.isCollabo)
        XCTAssertFalse(response.movie.isProtected)
        XCTAssertEqual(response.movie.maxViewCount, 1675)
        XCTAssertEqual(response.movie.currentViewCount, 20848)
        XCTAssertEqual(response.movie.totalViewCount, 20848)
        XCTAssertEqual(response.movie.hlsUrl, "https://twitcasting.tv/twitcasting_jp/metastream.m3u8/?video=1")
        
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
        XCTAssertEqual(response.comments[0].message, "モイ！")
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
        XCTAssertEqual(response.gifts[0].itemImage, "https://twitcasting.tv/img/item_tea.png")
        XCTAssertEqual(response.gifts[0].itemId, "tea")
        // https://apiv2-doc.twitcasting.tv/#get-gifts の Sample Response の例と異なり
        // gifts[0].itemId は、実際は整数型で戻って来ている
        XCTAssertEqual(response.gifts[0].itemMp, 10)
        XCTAssertEqual(response.gifts[0].itemName, "お茶")
        XCTAssertEqual(response.gifts[0].userImage, "http://202-234-44-53.moi.st/image3s/pbs.twimg.com/profile_images/613625726512705536/GLlBoXcS_normal.png")
        XCTAssertEqual(response.gifts[0].userScreenId, "twitcasting_jp")
        XCTAssertEqual(response.gifts[0].userScreenName, "twitcasting_jp")
        XCTAssertEqual(response.gifts[0].userName, "ツイキャス公式")

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
        XCTAssertEqual(response.categories[0].subCategories[0].name, "ミュージックch")
        XCTAssertEqual(response.categories[0].subCategories[0].count, 100)
        XCTAssertEqual(response.categories[1].id, "girls_jp")
        XCTAssertEqual(response.categories[1].subCategories.count, 3)
        XCTAssertEqual(response.categories[1].subCategories[0].id, "girls_face_jp")
        XCTAssertEqual(response.categories[1].subCategories[0].name, "女子：顔出し")
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

}
