//
//  DetailListViewController.swift
//  TableviewExample
//
//  Created by Kittiphong Xayasane on 2020-04-09.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

import UIKit

class DetailListViewController: UIViewController {
    lazy var viewModel: DetailListViewModel = {
        return DetailListViewModel(networkService: NetworkService())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViewModel()
        
        // Tell view model to fetch, bind our closures as view model property listeners
        fetchPokemon()
    }

    func setupViewModel() {
        // Binding view to view model
        viewModel.didStartFetch = { () in
            // Show loading UI
            if (self.viewModel.isLoading) {
                // Is loading
            } else {
                // Is not loading
            }
        }
        
        viewModel.didFinishFetching = { () in
            // Hide loading UI
        }
    }
    
    func fetchPokemon() {
        viewModel.fetchPokemon()
    }
}

