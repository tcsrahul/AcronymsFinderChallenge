//
//  URLSessionExtension.swift
//  AcronymsFinderChallenge
//
//  Created by 2325761 on 30/01/23.
//

import Foundation
import UIKit

extension Result where Success == Void {
  static var success: Result { return Result.success(()) }
}

struct NetworkRequestCode {
    static let ok = 200
    static let created = 201
    static let notModified = 304
    static let notStrong = 400
    static let badRequest = 400
    static let unauthorised = 401
    static let notPermitted = 403
    static let notFound = 404
    static let conflict = 409
    static let internalServerError = 500
    static let tokenExpired = 513
    static let requestTimeOut = -1001
    static let requestNotInternetConnected = -1009
    static let requestCanNotConnectToHost = -1004
    static let unknown = 0
}

struct ContentType {
    static let json = "application/json"
}

enum HTTPMethod: String {
    case get
    case post
}

enum RequestError: Error {
    case network(_ message: String, _ code: Int)
    case networkResponse(_ apiError: ApiErrorResponse, _ code: Int)
    case noData(_ message: String)
    case unknown
    case invalidToken
    case parseError
    case unsuccessful(_ message: String)

    static var networkUnknown: RequestError {
        return .network(Constant.HTTPErrorsText.apiFailureMessage, NetworkRequestCode.unknown)
    }

    static var errorInResponse: RequestError {
        return .network(Constant.HTTPErrorsText.apiFailureMessage, NetworkRequestCode.unknown)
    }

    var message: String {
        switch self {
        case .network(let msg, _):
            return msg
        case .networkResponse(let apiErr, _):
            return apiErr.customMessage ?? Constant.HTTPErrorsText.apiFailureMessage
        case .noData(let msg):
            return msg
        case .unsuccessful(let msg):
            return msg
        default:
            return Constant.HTTPErrorsText.apiFailureMessage
        }
    }

    var code: Int {
        switch self {
        case .network(_, let errCode):
            return errCode
        case .networkResponse(_, let errCode):
            return errCode
        default:
            return 0
        }
    }
}

struct ApiErrorResponse: Codable {
    let message: String?
    let invalidFieldNames: [String]?
    let violation: String?
    let customMessage: String?
}

extension URLSession {

    // This method sends network call and returns response in a closure
    func dataTask(with urlRequest: URLRequest,
                  result: @escaping (Result<(HTTPURLResponse, Data?), RequestError>) -> Void) -> URLSessionDataTask {
        return dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    switch error.code {
                    case NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet,
                    NSURLErrorDataNotAllowed:
                        result(.failure(.network(Constant.HTTPErrorsText.networkErrorMessage, NetworkRequestCode.requestNotInternetConnected)))
                    case NSURLErrorTimedOut:
                        result(.failure(.network(Constant.HTTPErrorsText.timeoutErrorMessage, NetworkRequestCode.requestTimeOut)))
                    case NSURLErrorCannotConnectToHost, NSURLErrorCannotFindHost:
                        result(.failure(.network(Constant.HTTPErrorsText.networkErrorMessage, NetworkRequestCode.requestCanNotConnectToHost)))
                    default:
                        if let httpResponse = response as? HTTPURLResponse {
                            result(.failure(.network(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode),
                                                     httpResponse.statusCode)))
                        } else {
                            result(.failure(.network(error.localizedDescription, NetworkRequestCode.unknown)))
                        }
                    }
// NotificationCenter.default.post(name: NSNotification.Name.noNetworkConnection, object: nil)
                    return
                }
// NotificationCenter.default.post(name: NSNotification.Name.hasNetworkConnection, object: nil)

                if let httpResponse = response as? HTTPURLResponse {
                    if let data = data {
                        _ = "For url request: \(urlRequest.description), received data is: \(String(decoding: data, as: UTF8.self))"
                    }
                    let errorStr = error?.localizedDescription ?? "Unknown"
                    switch httpResponse.statusCode {
                    case NetworkRequestCode.unauthorised:
                        result(.failure(.network(errorStr, NetworkRequestCode.unauthorised)))
                    case NetworkRequestCode.ok, NetworkRequestCode.created:
                        result(.success((httpResponse, data)))
                    case NetworkRequestCode.internalServerError:
                        result(.failure(.network(errorStr, NetworkRequestCode.internalServerError)))
                    case NetworkRequestCode.notStrong:
                        result(.failure(.network(errorStr, NetworkRequestCode.notStrong)))
                    default:
// TODO: RECORD ERROR TO CRASHLYTICS OR HOCKEYAPP
// let error = NSError(domain: kDMNetworkManagerErrorDomain, code: httpResponse.statusCode, userInfo: userInfo)
// Crashlytics.sharedInstance().recordError(error)
                        if let data = data, let apiError = try? JSONDecoder().decode(ApiErrorResponse.self, from: data) {
                            result(.failure(.networkResponse(apiError, httpResponse.statusCode)))
                        } else {
                            result(.failure(.network(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode), httpResponse.statusCode)))
                        }
                    }
                }
            }
        }
    }
}
