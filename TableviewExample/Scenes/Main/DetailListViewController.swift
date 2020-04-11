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
        return DetailListViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupViewModel()
        
        //tell view model to fetch, bind our closures as view model property listeners
        fetchPokemon()
    }

    func setupViewModel() {
        // binding
        viewModel.someClosure = { () in
            print("yeet")
        }
    }
    
    func fetchPokemon() {
//        viewModel.fetchPokemon()
        
        //bind our ui to viewmodel (progress bar status, spinning bar, refresh list)
    }
}

