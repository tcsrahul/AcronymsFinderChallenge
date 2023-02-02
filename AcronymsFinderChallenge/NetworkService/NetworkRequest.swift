//
//  NetworkRequest.swift
//  AcronymsFinderChallenge
//
//  Created by 2325761 on 30/01/23.
//

import Foundation

extension URLRequest {
    static let defaultTimeout = 15.0

    //Method that creates URLRequest object based on the parameters
    static func createRequest(_ url: URL, httpMethod: HTTPMethod = .post, body: Data? = nil,
                              contentType: String = ContentType.json, includeAuth: Bool = true) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        request.timeoutInterval = URLRequest.defaultTimeout
        request.addValue(contentType, forHTTPHeaderField: Constant.HTTPHeadersKeys.contentTypeKey)
        return request
    }
}
