//
//  NetworkReachability.swift
//  Telstra
//
//  Created by Syed Amais on 11/5/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import Foundation
import Network

struct NetworkReachability {
    
    static var shared = NetworkReachability()
    
    /// To check if the  phone is connected to internet and notification "networkReachability" is fired on connectivity status changed
    var isConnected = true {
        didSet {
            let connectionStatus = isConnected
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationNames.networkReachability), object: connectionStatus)
        }
    }
    
    private init(){
        startCheckingForConnectivity()
    }
    
    /// continuously checks internet connectivity status and
    private func startCheckingForConnectivity() {
        let networkMoniter = NWPathMonitor()
        let queue = DispatchQueue.global(qos: .background)
        networkMoniter.start(queue: queue)
        networkMoniter.pathUpdateHandler = { path in
            NetworkReachability.shared.isConnected = path.status == .satisfied
        }
    }
}
