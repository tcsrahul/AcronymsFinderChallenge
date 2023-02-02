//
//  APIManagement.swift
//  AcronymsFinderChallenge
//
//  Created by 2325761 on 30/01/23.
//

import Foundation

enum APIManagement {
    case dictionary(String)
}

extension APIManagement {

    //Base URL
    static var baseURL: String {
        return Constant.ULRs.baseURL
    }

    //URL for specific service
    var url: String {
        switch self {
        case .dictionary(let sf):
            return "\(APIManagement.baseURL)?sf=\(sf)"
        }
    }

    //Request body for specific service
    var body: Data? {
        switch self {
        case .dictionary:
            return nil
        }
    }

    //Network request for specific service
    var networkRequest: URLRequest? {
        guard let url = URL(string: url) else { return nil }
        switch self {
        case .dictionary:
            return URLRequest.createRequest(url, httpMethod: .get,
                                              body: body,
                                              contentType: ContentType.json)
        }
    }
}
