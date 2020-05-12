//
//  HTTPMethod.swift
//  Telstra
//
//  Created by Syed Amais on 11/5/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import Foundation


/// Defines different HTTP request methods
enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}
