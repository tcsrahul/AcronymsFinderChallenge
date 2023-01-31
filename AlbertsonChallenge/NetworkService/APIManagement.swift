//
//  APIManagement.swift
//  AlbertsonChallenge
//
//  Created by 2325761 on 30/01/23.
//

import Foundation

enum APIManagement {
    case dictionary(String)
}

extension APIManagement {

    static var baseURL: String {
        return Constant.ULRs.baseURL
    }

    var url: String {
        switch self {
        case .dictionary(let sf):
            return "\(APIManagement.baseURL)?sf=\(sf)"
        }
    }

    var body: Data? {
        switch self {
        case .dictionary:
            return nil
        }
    }

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

