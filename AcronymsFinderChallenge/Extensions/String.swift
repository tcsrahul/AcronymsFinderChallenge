//
//  String.swift
//  AcronymsFinderChallengeTests
//
//  Created by Rahul Gupta on 27/07/21.
//

import UIKit
import Network

public extension String {

    //Computed variable that returns localized strings
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
