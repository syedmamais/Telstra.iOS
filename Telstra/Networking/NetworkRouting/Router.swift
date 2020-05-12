//
//  Router.swift
//  Telstra
//
//  Created by Syed Amais on 11/5/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import Foundation

typealias NetworkCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

/// Provides interface for network routing and defines an associated type *EndPoint* confirming to *EndPointType* protocol
protocol Router{
    
    associatedtype EndPoint: EndPointType
    
    @discardableResult
    func request(endPoint: EndPoint, completion: @escaping NetworkCompletion) -> URLSessionTask?
}
