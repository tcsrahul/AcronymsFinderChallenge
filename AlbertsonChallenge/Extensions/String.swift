//
//  String.swift
//  POApproval
//
//  Created by Rahul Gupta on 27/07/21.
//

import UIKit
import Network

public extension String {

    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }

    func localized(comment: String = "", bundle: Bundle = Bundle.main) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    }
}
