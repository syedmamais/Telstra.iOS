//
//  HTTPTask.swift
//  Telstra
//
//  Created by Syed Amais on 11/5/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import Foundation


/// Defines request with *HTTPParameters* for  *URLRequest* query parameters
enum HTTPTask {
    case request(urlParams: HTTPParameters?)
}

