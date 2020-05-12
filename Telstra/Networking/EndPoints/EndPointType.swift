//
//  EndPointType.swift
//  Telstra
//
//  Created by Syed Amais on 11/5/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import Foundation

/// Defines Endpoint to provide required properties for any API endpoint
protocol EndPointType {
    var baseURL     : URL { get }
    var path        : String { get }
    var httpMethod  : HTTPMethod { get }
    var task        : HTTPTask { get }
}
