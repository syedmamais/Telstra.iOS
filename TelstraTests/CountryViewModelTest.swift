//
//  CountryViewModelTest.swift
//  TelstraTests
//
//  Created by Syed Amais on 13/5/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import XCTest

@testable import Telstra

class CountryViewModelTest: XCTestCase, MockCountryData {

    var countryVM: CountryViewModel!
    var testIndex = 2
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        countryVM = CountryViewModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        countryVM = nil
    }

    func testNumberOfFacts() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let countryData = dataFromJsonFile()
        XCTAssertNotNil(countryData, "Country data not found in json file")
        if let country = countryData, let facts = country.facts {
            countryVM.setCountryFacts(input: facts)
            countryVM.setCountryTitle(input: country.title)
            let viewModelFacts = countryVM.countryFactsCount()
            XCTAssertEqual(viewModelFacts, facts.count)
            
        }
    }
    func testMatchQuestionAtTestIndex() {
        let countryData = dataFromJsonFile()
        XCTAssertNotNil(countryData, "Country data not found in json file")
        if let country = countryData, let facts = country.facts {
            countryVM.setCountryFacts(input: facts)
            countryVM.setCountryTitle(input: country.title)
            let viewModelFact = countryVM.factAtIndex(index: testIndex)
            let fact = facts[testIndex]
            XCTAssertEqual(viewModelFact?.title, fact.title)
            XCTAssertEqual(viewModelFact?.description, fact.description)
            XCTAssertEqual(viewModelFact?.imageUrl, fact.imageUrl)

        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
