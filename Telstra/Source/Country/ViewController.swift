//
//  ViewController.swift
//  Telstra
//
//  Created by Syed Amais on 11/5/20.
//  Copyright © 2020 Cognizant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var countryTable: UITableView = {
        let tableView = UITableView()
        tableView.register(FactCell.self, forCellReuseIdentifier: CellIdentifiers.factCellIdentifier)
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    /// Setup ViewModel for Country Data
    lazy var countryVM : CountryViewModel = {
        let countryVM = CountryViewModel()
        return countryVM
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCountryData()
        initViewModel()
        bindViewModel()
        setupUI()
    }
    
    func setupUI() {
        view.addSubview(countryTable)
        countryTable.translatesAutoresizingMaskIntoConstraints = false
        countryTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        countryTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        countryTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        countryTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func initViewModel() {
        
        countryVM.dataFetched = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.countryTable.reloadData()
                self?.title = self?.countryVM.countryTitle
            }
        }
    }
    
}

// MARK: - Country Data
extension ViewController {
    
    @objc func loadCountryData() {
        countryVM.fetchCountryData()
    }
}

// MARK:- View Model Error binding
extension ViewController: AlertService {

    func bindViewModel() {
        countryVM.dataFetchFailed = { [weak self] errorString in
            self?.showAlert(titleStr: "Error", messageStr: errorString, okButtonTitle: "OK", cancelButtonTitle: nil, response: nil)
        }
    }
}


//MARK:- UITableView delegate and Data source methods
extension ViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if countryVM.countryFactsCount() > 0 {
            return countryVM.countryFactsCount()
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue and configure the cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.factCellIdentifier, for: indexPath) as? FactCell, let fact = countryVM.factAtIndex(index: indexPath.row) else { return UITableViewCell() }
        
        cell.configureFactCell(fact: fact)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

