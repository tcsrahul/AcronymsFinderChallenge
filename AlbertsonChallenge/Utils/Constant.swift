//
//  Constant.swift
//  AlbertsonChallenge
//
//  Created by 2325761 on 30/01/23.
//

import Foundation

public struct Constant {
    public struct ULRs {
        static let baseURL = "http://www.nactem.ac.uk/software/acromine/dictionary.py"
    }

    public struct HTTPErrorsText {
        public static let networkErrorMessage = "Network is not available. Please check your connection."
        public static let networkErrorTitle = "Network Not Available".localized
        public static let apiFailureMessage = "Oops! Something went wrong."
        public static let timeoutErrorMessage = "Unable to connect Mobile/WiFI Network. Please try again."
        public static let tokensAreExpired = "Tokens are expired!"
        public static let loginFailed = "Login Failed"
    }

    public struct HTTPHeadersKeys {
        public static let authorizationKey = "Authorization"
        public static let contentTypeKey = "Content-Type"
        public static let appVersionName = "appVersionName"
        public static let osVersion = "osVersion"
    }
}
