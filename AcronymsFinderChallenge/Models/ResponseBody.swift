//
//  ResponseBody.swift
//  AcronymsFinderChallenge
//
//  Created by 2325761 on 30/01/23.
//

import Foundation

// MARK: - AcronymDictionary
struct AcronymDictionary: Codable {
    let sf: String
    let lfs: [LF]
}

// MARK: - LF
struct LF: Codable {
    let lf: String
    let freq, since: Int
    let vars: [LF]?
}
