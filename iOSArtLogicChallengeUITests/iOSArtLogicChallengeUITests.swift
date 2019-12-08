//
//  iOSArtLogicChallengeUITests.swift
//  iOSArtLogicChallengeUITests
//
//  Created by Ramon Haro Marques on 06/12/2019.
//  Copyright © 2019 Ramon Haro Marques. All rights reserved.
//

import XCTest

class iOSArtLogicChallengeUITests: XCTestCase {
    
    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        
        print("Hello from setup")
        continueAfterFailure = true
        
        app = XCUIApplication()
        //Uncomment next line to use MOCKNetwork for the app
        app.launchArguments = ["TEST"]
        app.launch()
        
    }
    
    func test_WhenDataIsFetched_ThenShowResults() {
        
        let element = app.cells.containing(.staticText, identifier: "Cellar Door").firstMatch
        XCTAssert(element.exists)
        
        element.tap()
        
        let presentationItemResult = "   Brian Fekete    Encyclopedic Series No. 6    2011    graphite and pencil on paper    22 x 17 in. "

        let presentationElement = app.staticTexts[presentationItemResult].firstMatch
        XCTAssert(presentationElement.waitForExistence(timeout: 10))
        
    }
    
}
