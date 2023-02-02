//
//  AcronymsFinderChallengeUITests.swift
//  AcronymsFinderChallengeUITests
//
//  Created by 2325761 on 27/01/23.
//

import XCTest

final class AcronymsFinderChallengeUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //Method that test Dashboard UI
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        let acronymSearchbar = app.searchFields["Enter Text To Search"]
        XCTAssert(acronymSearchbar.exists)

        acronymSearchbar.tap()
        acronymSearchbar.typeText("hmm")

        let cancel = app.buttons["Cancel"]
        XCTAssert(cancel.exists)

        XCTAssertNotEqual(acronymSearchbar.value as! String, "")
        XCTAssertEqual(acronymSearchbar.value as! String, "hmm")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
