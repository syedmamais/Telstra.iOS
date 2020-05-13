//
//  MockCountryData.swift
//  TelstraTests
//
//  Created by Syed Amais on 13/5/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import Foundation
@testable import Telstra

protocol MockCountryData {
    @discardableResult
    func dataFromJsonFile() -> Country?
}
extension MockCountryData {
    @discardableResult
    func dataFromJsonFile() -> Country? {
        guard let url = Bundle.main.url(forResource: "countryData", withExtension: "json") else { return nil}
        guard let mockResponse: String = try? String(contentsOf: url) else { return nil }
        guard let utf8Data = mockResponse.data(using: .utf8) else { return nil }
        let jsonDecoder = JSONDecoder()
        let response = try? jsonDecoder.decode(Country.self, from: utf8Data)
        return response
    }
}
