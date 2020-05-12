//
//  CountryViewModel.swift
//  Telstra
//
//  Created by Syed Amais on 12/5/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import Foundation

class CountryViewModel {
    
    private var countryService          = CountryService(NetworkHandler())
    private(set) var countryFacts       = [Fact]()
    private(set) var countryTitle       = String()
    
    //MARK: Closure
    var dataFetched             : (() -> ())?
    var dataFetchFailed         : ((_ error: String)->())?
    
    init() {}
    
    /// Returns array of *Facts*
    func getCountryFacts() -> [Fact]? {
        return countryFacts
    }
    
    /// Returns string of *Title*
    func getCountryTitle() -> String? {
        return countryTitle
    }
    
    /// Returns total number of facts in country response
    func countryFactsCount() -> Int {
        return countryFacts.count
    }
    
    /// Returns a *Fact* at specific index
    ///
    /// - Parameter index: Array Index
    func factAtIndex(index: Int) -> Fact? {
        guard index >= 0 && index < countryFacts.count else { return nil }
        return countryFacts[index]
    }
    
    /// Function to set facts data in the model
    ///
    /// - Parameter input: Array of items returned from the query
    func setCountryFacts(input: [Fact]?) {
        if let input = input {
            countryFacts = input
        }
    }
    
    /// Function to set country tite in the model
    ///
    /// - Parameter input: Array of items returned from the query
    func setCountryTitle(input: String?) {
        if let input = input {
            countryTitle = input
        }
    }
    
}

//MARK: API
extension CountryViewModel {
    
    /// Fetch a list of country facts from network and calls either the *dataFetchFailed* closure on error or the *dataFetched* on successfully getting the country data
    func fetchCountryData() {
        countryService.fetchCountryData { [weak self] (response, error) in
            if let error = error {
                self?.dataFetchFailed?(error)
            } else if let response = response {
                self?.setCountryFacts(input: response.facts)
                self?.setCountryTitle(input: response.title)
                self?.dataFetched?()
            }
        }
    }
}
