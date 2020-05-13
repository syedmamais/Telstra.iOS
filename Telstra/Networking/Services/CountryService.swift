//
//  CountryService.swift
//  Telstra
//
//  Created by Syed Amais on 11/5/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//


import Foundation

typealias CountryCompletionBlock = (_ country: Country?,_ error: String?)-> ()

/// Service for fetching country facts from the network
struct CountryService {
    var networkHandler: NetworkHandler
    init(_ networkHandle: NetworkHandler) {
        networkHandler = networkHandle
    }
}

extension CountryService {
    
    /// Fetches the list of country facts using the *FactsAPI. *
    /// - Parameter completion: completion closure with object of *Country*  or error string
    func fetchCountryData(_ completion: @escaping CountryCompletionBlock) {
        networkHandler.fetchData(CountryAPI.factsDataList, completion: {(data, error) in
            guard let data = data else {
                completion(nil,error)
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                guard let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8) else {
                    completion(nil,"Response data is not valid")
                    return
                }
                
                let countryData = try jsonDecoder.decode(Country.self, from: utf8Data)
                guard (countryData.facts != nil) else {
                    completion(nil,"Facts data not found!")
                    return
                }
                
                completion(countryData, nil)
                
            } catch {
                completion(nil, NetworkResponse.unableToDecode.rawValue)
            }
        })
    }
}
