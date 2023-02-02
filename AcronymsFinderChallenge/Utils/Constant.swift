//
//  Constant.swift
//  AcronymsFinderChallenge
//
//  Created by 2325761 on 30/01/23.
//

import Foundation

struct Constant {
    //Structure which holds remote URL
    struct ULRs {
        static let baseURL = "http://www.nactem.ac.uk/software/acromine/dictionary.py"
    }

    //Structure which holds error message
    struct HTTPErrorsText {
        static let networkErrorMessage = "Network is not available. Please check your connection."
        static let networkErrorTitle = "Network Not Available".localized
        static let apiFailureMessage = "Oops! Something went wrong."
        static let timeoutErrorMessage = "Unable to connect Mobile/WiFI Network. Please try again."
    }

    //Structure which holds request headers
    struct HTTPHeadersKeys {
        static let contentTypeKey = "Content-Type"
    }

    //Structure which holds strings
    struct Strings {
        static let ok = "OK"
        static let alert = "Alert"
    }
}
