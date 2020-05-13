//
//  FactCell.swift
//  Telstra
//
//  Created by Syed Amais on 12/5/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import UIKit

class FactCell: UITableViewCell {
    
    let factTitle            = UILabel()
    let factImage            = UIImageView()
    let factDescription      = UILabel()
    
    var networkHandler       = NetworkHandler()
    var viewModel            : FactViewModel?
    
    var contrainerViewHeight : NSLayoutConstraint!
    
    // MARK: Initalizers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(factImage)
        contentView.addSubview(factTitle)
        contentView.addSubview(factDescription)
        
        let marginGuide = contentView.layoutMarginsGuide

        // configure fact image
        factImage.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        factImage.clipsToBounds = true
        factImage.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        factImage.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant:10).isActive = true
        factImage.widthAnchor.constraint(equalToConstant:60).isActive = true
        factImage.heightAnchor.constraint(equalToConstant:60).isActive = true
        
        // configure fact title
        factTitle.translatesAutoresizingMaskIntoConstraints = false
        factTitle.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        factTitle.leadingAnchor.constraint(equalTo: self.factImage.trailingAnchor, constant:10).isActive = true
        factTitle.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        factTitle.numberOfLines = 0
        factTitle.font = UIFont.systemFont(ofSize: 16)
        
        // configure fact description
        factDescription.translatesAutoresizingMaskIntoConstraints = false
        factDescription.topAnchor.constraint(equalTo:self.factTitle.bottomAnchor).isActive = true
        factDescription.leadingAnchor.constraint(equalTo:self.factImage.trailingAnchor, constant:10).isActive = true
        factDescription.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        factDescription.numberOfLines = 0
        factDescription.font = UIFont.systemFont(ofSize: 14)
        factDescription.textColor = UIColor.lightGray
        
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
        contentView.bottomAnchor.constraint(equalTo: factDescription.bottomAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureFactCell(fact: Fact) {
        // Configure the cell...
        viewModel = FactViewModel(fact)
        viewModel?.ImageFetched = { [weak self] image in
            DispatchQueue.main.async { [weak self] in
                UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: { [weak self] in
                    self?.factImage.image = image
                    }, completion: nil)
            }
        }
        viewModel?.fetchImage()
        factTitle.text = viewModel?.factTitle()
        factDescription.text = viewModel?.factDescription()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        factTitle.text  = nil
        factDescription.text  = nil
        factImage.image = nil
        
    }
    
    
}
