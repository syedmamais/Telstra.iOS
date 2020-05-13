//
//  CountryAPI.swift
//  Telstra
//
//  Created by Syed Amais on 11/5/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import Foundation


/// Define different endpoint cases for the Facts API to be used for network request
enum CountryAPI {
    case factsDataList
    case image(path: String)
}

extension CountryAPI: EndPointType {
    
    /// computed property for providing base url based on the network environment
    private var envBaseURL: String {
        switch self {
        case .image(let path):
            return path
        default:
            switch NetworkHandler.environment {
            case .production, .staging, .development:
                return "https://dl.dropboxusercontent.com/"
            }
        }
    }
    
    /// computed property for providing a *URL* with the base url string
    var baseURL: URL {
        guard let url = URL(string: envBaseURL) else {fatalError("Invalid Base URL.")}
        return url
    }
    
    /// computed property to provide specific path for each API end point
    var path: String {
        switch self {
        case .factsDataList:
            return "s/2iodh4vg0eortkl/facts.json"
        case .image:
            return ""
        }
    }
    
    /// computed property to provide HTTP request method to be used in network request
    var httpMethod: HTTPMethod {
        return .get
    }
    
    /// computed property to provide request with specific query string parameters if required
    var task: HTTPTask {
       return .request(urlParams: nil)
    }
}
