//
//  CountryServiceTest.swift
//  TelstraTests
//
//  Created by Syed Amais on 13/5/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import XCTest
@testable import Telstra

class DailyBuzzServiceTest: XCTestCase {

    var sut: CountryService!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = CountryService(NetworkHandler())
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }

    func testData() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let dataReceivedPromise = expectation(description: "Data is received Successfully")
        sut.fetchCountryData{ (data, error) in
            if let facts = data?.facts {
                dataReceivedPromise.fulfill()
                XCTAssertNotNil(facts, "Country API response is nil")
                XCTAssertGreaterThan(facts.count, 0, "Facts list is empty")
                if !facts.isEmpty {
                    XCTAssertTrue(facts.count > 0, "Facts data received.")
                } else {
                    XCTFail("Error: facts are nil")
                }
            }
        }
        wait(for: [dataReceivedPromise], timeout: 3.0)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            testData()
        }
    }

}
