//
//  FactViewModel.swift
//  Telstra
//
//  Created by Syed Amais on 13/5/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import Foundation
import UIKit

typealias ImageFetched = ((_ image: UIImage)->())

/// viewModel to serve the *CarView*
class FactViewModel {
    private var factModel   : Fact!
    var imageService        = ImageService(NetworkHandler())
    
    //MARK: Closures
    var ImageFetched        : ((_ image:UIImage)->())?
    
    private init(){}

    /// convenience initialiser to initialise view model with a *Fact* model
    /// - Parameter factModel: *Fact* model
    convenience init(_ fact:Fact) {
        self.init()
        factModel = fact
    }
    
}
//MARK:- View Service Methods
extension FactViewModel {
    
    /// fetches car image
    func fetchImage() {
        guard let factModel = factModel else { return }
        fetchImageForCell(model: factModel)
    }
    
    /// Returns fact description or an empty string if *description* is nil
    func factDescription() -> String {
        return factModel.description ?? "N/A"
    }
    
    /// Returns fact title name or an empty string if *title* is nil
    func factTitle() -> String {
        return factModel.title ?? "N/A"
    }
}

//MARK: Network Fetch Methods
extension FactViewModel {
    
    private func fetchImageForCell(model: Fact) {
        var path: String?
        path = model.imageUrl
        guard let photoPath = path else { return }
        imageService.fetchImage(photoPath, completion: { [weak self] (image, errorString) in
            if let image = image {
                self?.ImageFetched?(image)
            }
        })
    }
}
