//
//  ImageService.swift
//  Telstra
//
//  Created by Syed Amais on 13/5/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import Foundation
import UIKit

typealias ImageCompletionBlock = (_ image: UIImage?,_ error: String?)-> ()

struct ImageService {
    var networkHandler: NetworkHandler
    init(_ networkHandle: NetworkHandler) {
        networkHandler = networkHandle
    }
}
extension ImageService {
    func fetchImage(_ path: String, completion: @escaping ImageCompletionBlock) {
        networkHandler.fetchData(CountryAPI.image(path: path), completion: {(data, error) in
            guard let data = data else {
                 completion(nil,error)
                return
            }
            if let image = UIImage(data: data) {
                completion(image, nil)
            } else {
                completion(nil, NetworkResponse.unableToDecode.rawValue)
            }
        })
    }
}
