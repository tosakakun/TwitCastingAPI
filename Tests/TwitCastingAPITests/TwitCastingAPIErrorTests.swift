//
//  TwitCastingAPIErrorTests.swift
//  TwitCastingAPI
//
//  Created by tosakakun on 2022/06/02.
//

import Foundation
import XCTest
@testable import TwitCastingAPI

final class TwitCastingAPIErrorTests: TwitCastingAPITestCase {
    
    private func send<R: TCBaseRequest>(request: R, parameter: R.Request? = nil, check: (TCError) -> Void) async {
        
        do {
            let _ = try await request.send(parameter: parameter)
            XCTFail("No error occurred")
        } catch let error as TCError {
            check(error)
        } catch {
            XCTFail("General Error Throwed")
        }
    }
    
    func testInvalidToken() async throws {
        
        setMockData(fileName: "InvalidToken", statusCode: 401)
        
        let request = TCGetUserInfoRequest(token: "token", userId: "twitcasting_jp")
        
        await send(request: request, check: { error in
            if case .invalidToken(let code, let message)  = error {
                XCTAssertEqual(code, 1000)
                XCTAssertEqual(message, "Invalid token")
            } else {
                XCTFail("Invalid Error Type")
            }
        })
        
    }
    
    func testValidationError() async throws {
        
        setMockData(fileName: "ValidationError", statusCode: 400)
        
        let movieId = "189037369"
        
        let request = TCGetCommentsRequest(token: "token", movieId: movieId)
        let parameter = TCGetCommentsRequest.Parameter(offset: 10, limit: 10, sliceId: nil)
        
        await send(request: request, parameter: parameter, check: { error in
            if case .validationError(let code, let message, let details) = error {
                XCTAssertEqual(code, 1001)
                XCTAssertEqual(message, "Validation error")
                XCTAssertEqual(details, ["limit": ["intVal"], "offset": ["min"]])
            } else {
                XCTFail("Invalid Error Type")
            }
        })
        
    }
    
    func testExecutionCountLimitation() async throws {
        
        setMockData(fileName: "ExecutionCountLimitation", statusCode: 403)
        
        let request = TCGetUserInfoRequest(token: "token", userId: "twitcasting_jp")
        
        await send(request: request, check: { error in
            if case .executionCountLimitation(let code, let message) = error {
                XCTAssertEqual(code, 2000)
                XCTAssertEqual(message, "Execution count limitation")
            } else {
                XCTFail("Invalid Error Type")
            }
        })
        
    }
    
    func testApplicationDisabled() async throws {
        
        setMockData(fileName: "ApplicationDisabled", statusCode: 403)
        
        let request = TCGetUserInfoRequest(token: "token", userId: "twitcasting_jp")
        
        await send(request: request, check: { error in
            if case .applicationDisabled(let code, let message) = error {
                XCTAssertEqual(code, 2001)
                XCTAssertEqual(message, "Application is disabled")
            } else {
                XCTFail("Invalid Error Type")
            }
        })

    }
    
    func testProtected() async throws {
        
        setMockData(fileName: "Protected", statusCode: 403)
        
        let movieId = "189037369"
        
        let request = TCPostCommentRequest(token: "token", movieId: movieId)
        let parameter = TCPostCommentRequest.Parameter(comment: "モイ！", sns: .none)
        
        await send(request: request, parameter: parameter, check: { error in
            if case .protected(let code, let message) = error {
                XCTAssertEqual(code, 2002)
                XCTAssertEqual(message, "Protected")
            } else {
                XCTFail("Invalid Error Type")
            }
        })
        
    }
    
    func testDuplicate() async throws {
        
        setMockData(fileName: "Duplicate", statusCode: 403)
        
        let movieId = "189037369"
        
        let request = TCPostCommentRequest(token: "token", movieId: movieId)
        let parameter = TCPostCommentRequest.Parameter(comment: "モイ！", sns: .none)
        
        await send(request: request, parameter: parameter, check: { error in
            if case .duplicate(let code, let message) = error {
                XCTAssertEqual(code, 2003)
                XCTAssertEqual(message, "Duplicate")
            } else {
                XCTFail("Invalid Error Type")
            }
        })

    }
    
    func testTooManyComments() async throws {
        
        setMockData(fileName: "TooManyComments", statusCode: 403)
        
        let movieId = "189037369"
        
        let request = TCPostCommentRequest(token: "token", movieId: movieId)
        let parameter = TCPostCommentRequest.Parameter(comment: "モイ！", sns: .none)
        
        await send(request: request, parameter: parameter, check: { error in
            if case .tooManyComments(let code, let message) = error {
                XCTAssertEqual(code, 2004)
                XCTAssertEqual(message, "Too many comments")
            } else {
                XCTFail("Invalid Error Type")
            }
        })

    }
    
    func testOutOfScope() async throws {
        
        setMockData(fileName: "OutOfScope", statusCode: 403)
        
        let movieId = "189037369"
        let commentId = "123456"
        
        let request = TCDeleteCommentRequest(token: "token", movieId: movieId, commentId: commentId)
        
        await send(request: request, check: { error in
            if case .outOfScope(let code, let message) = error {
                XCTAssertEqual(code, 2005)
                XCTAssertEqual(message, "Out of scope")
            } else {
                XCTFail("Invalid Error Type")
            }
        })
        
    }
    
    func testEmailUnverified() async throws {
        
        setMockData(fileName: "EmailUnverified", statusCode: 403)
        
        let request = TCGetRTMPUrlRequest(token: "token")
        
        await send(request: request, check: { error in
            if case .emailUnverified(let code, let message) = error {
                XCTAssertEqual(code, 2006)
                XCTAssertEqual(message, "Email is not verified")
            } else {
                XCTFail("Invalid Error Type")
            }
        })

    }
    
    func testBadRequest() async throws {
        
        setMockData(fileName: "BadRequest", statusCode: 400)
        
        let targetId = "casma_jp"
        
        let request = TCGetSupportingStatusRequest(token: "token", userId: "twitcasting_dev")
        let parameter = TCGetSupportingStatusRequest.Parameter(targetUserId: targetId)
        
        await send(request: request, parameter: parameter, check: { error in
            if case .badRequest(let code, let message) = error {
                XCTAssertEqual(code, 400)
                XCTAssertEqual(message, "Bad Request")
            } else {
                XCTFail("Invalid Error Type")
            }
        })

    }
    
    func testForbidden() async throws {
        
        setMockData(fileName: "Forbidden", statusCode: 403)
        
        let movieId = "189037369"
        let commentId = "123456"
        
        let request = TCDeleteCommentRequest(token: "token", movieId: movieId, commentId: commentId)
        
        await send(request: request) { error in
            if case .forbidden(let code, let message)  = error {
                XCTAssertEqual(code, 403)
                XCTAssertEqual(message, "Forbidden")
            } else {
                XCTFail("Invalid Error Type")
            }
        }
        
    }
    
    func testNotFound() async throws {
        
        setMockData(fileName: "NotFound", statusCode: 404)
        
        let request = TCGetUserInfoRequest(token: "token", userId: "twitcasting_jp")
        
        await send(request: request) { error in
            if case .notFound(let code, let message) = error {
                XCTAssertEqual(code, 404)
                XCTAssertEqual(message, "Not Found")
            } else {
                XCTFail("Invalid Error Type")
            }
        }
        
    }
    
    func testInternalServerError() async throws {
        
        setMockData(fileName: "InternalServerError", statusCode: 500)
        
        let request = TCGetUserInfoRequest(token: "token", userId: "twitcasting_jp")
        
        await send(request: request) { error in
            if case .internalServerError(let code, let message) = error {
                XCTAssertEqual(code, 500)
                XCTAssertEqual(message, "Internal Server Error")
            } else {
                XCTFail("Invalid Error Type")
            }
        }
    }
}
