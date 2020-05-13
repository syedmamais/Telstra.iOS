//
//  FactCell.swift
//  Telstra
//
//  Created by Syed Amais on 12/5/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import UIKit

class FactCell: UITableViewCell {
    
    let factTitle           = UILabel()
    let factImage           = UIImageView()
    let factDescription     = UILabel()
    
    var networkHandler      = NetworkHandler()
    var viewModel           : FactViewModel?
    
    let containerView       : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    // MARK: Initalizers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(factImage)
        containerView.addSubview(factTitle)
        containerView.addSubview(factDescription)
        self.contentView.addSubview(containerView)
        
        // configure fact image
        factImage.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        factImage.clipsToBounds = true
        factImage.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        factImage.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        factImage.widthAnchor.constraint(equalToConstant:60).isActive = true
        factImage.heightAnchor.constraint(equalToConstant:60).isActive = true
        
        
        // configure container view
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.factImage.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        
        // configure fact title
        factTitle.translatesAutoresizingMaskIntoConstraints = false
        factTitle.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        factTitle.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        factTitle.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        factTitle.numberOfLines = 0
        factTitle.font = UIFont.systemFont(ofSize: 16)
        
        // configure fact description
        factDescription.translatesAutoresizingMaskIntoConstraints = false
        factDescription.lineBreakMode = .byWordWrapping
        factDescription.topAnchor.constraint(equalTo:self.factTitle.bottomAnchor).isActive = true
        factDescription.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        factDescription.topAnchor.constraint(equalTo:self.factTitle.bottomAnchor).isActive = true
        factDescription.numberOfLines = 0
        factDescription.font = UIFont.systemFont(ofSize: 12)
        factDescription.textColor = UIColor.lightGray
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
