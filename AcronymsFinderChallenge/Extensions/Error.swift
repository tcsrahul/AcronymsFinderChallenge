//
//  Error.swift
//  AcronymsFinderChallenge
//
//  Created by 2325761 on 30/01/23.
//

import Foundation

public extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}
