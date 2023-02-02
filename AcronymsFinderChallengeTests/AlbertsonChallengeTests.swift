//
//  AcronymsFinderChallengeTests.swift
//  AcronymsFinderChallengeTests
//
//  Created by 2325761 on 27/01/23.
//

import XCTest
@testable import AcronymsFinderChallenge

final class AcronymsFinderChallengeTests: XCTestCase {

    var dashboardViewModel: DashboardViewModel?

    override func setUpWithError() throws {
        dashboardViewModel = DashboardViewModel()
    }

    override func tearDownWithError() throws {
        dashboardViewModel = nil
    }

    //Mehtod that test webservice when there is text on searchbar
    func test_search_service_withText() {
        dashboardViewModel?.searchAcronym(searchText: "hmm")
        let expectation = XCTestExpectation()
        dashboardViewModel?.reloadTableView = {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
        XCTAssertGreaterThan(dashboardViewModel?.getAcronymCount() ?? 0, 0)
    }

    //Mehtod that test webservice when there is no text on searchbar
    func test_search_service_withoutText() {
        dashboardViewModel?.searchAcronym(searchText: "")
        let expectation = XCTestExpectation()
        dashboardViewModel?.reloadTableView = {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
        XCTAssertLessThan(dashboardViewModel?.getAcronymCount() ?? 0, 1)
    }
}
