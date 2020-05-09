//
//  PokemonsViewController.swift
//  TableviewExample
//
//  Created by Kittiphong Xayasane on 2020-04-09.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

import UIKit

private let kCellIdentifier = "pokemonCellIdentifier"

class PokemonsViewController: UIViewController {
    var viewModel: PokemonsViewModel = PokemonsViewModel(networkService: NetworkService())
    var tableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        setupViewModel()
        
        setupViews()
        // Tell view model to fetch, bind our closures as view model property listeners
        fetchPokemon()
    }

    func setupViewModel() {
        // Binding view to view model
        viewModel.startedFetchHandler = { () in
            // Show loading UI
            if (self.viewModel.isLoading) {
                // Is loading
                print("didStartFetch: viewModel is loading.")
            } else {
                // Is not loading
                print("didStartFetch: viewModel is not loading.")
            }
        }
        
        viewModel.fetchCompletionHandler = { () in
            // Hide loading UI
            print("Did finish fetching")
        }
        
        viewModel.dataRefreshHandler = { () in
            print("Refresh table view")
            self.tableView.reloadData()
        }
    }
    
    func setupViews() {
        view.addSubview(tableView)
        setupTableViewConstraints()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PokemonItemCell.self, forCellReuseIdentifier: kCellIdentifier)
    }
    
    func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func fetchPokemon() {
        viewModel.fetchPokemon()
    }
}

extension PokemonsViewController: UITableViewDelegate {
    
}

extension PokemonsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as? PokemonItemCell else { fatalError("DequeueReusableCell cell does not exist!") }
        
        let pokemonViewModel = viewModel.getViewModel(forIndexPath: indexPath)
        cell.viewModel = pokemonViewModel
        
        return cell;
    }
    
    
}
