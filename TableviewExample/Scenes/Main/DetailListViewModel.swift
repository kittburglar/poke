//
//  DetailListViewModel.swift
//  TableviewExample
//
//  Created by Kittiphong Xayasane on 2020-04-10.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

import Foundation

class DetailListViewModel {
    //MARK: - Model object
    //Private to seperate view from model
    private let networkService: NetworkService?
    private var pokemons: Pokemons? {
        didSet {
            self.didFinishFetching?()
        }
    }
    
    
    // MARK: - State properties
    var isLoading: Bool = false {
        didSet {
            self.didStartFetch?()
        }
    }
    
    
    // MARK: - Binding closures
    var didStartFetch: (()->())?
    var didFinishFetching: (()->())?
    
    // MARK: Class Initializers
    init(networkService: NetworkService) {
        // Dependency injection
        self.networkService = networkService
    }
    
    // MARK: - Helper Methods
    
    func fetchPokemon() {
        isLoading = true
        self.networkService?.sendRequest(withEndpoint: Endpoint.pokemon.rawValue) { (data, response, error) in
            self.isLoading = false
            if (error != nil) {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let pokemons = try JSONDecoder().decode(Pokemons.self, from: data)
                self.pokemons = pokemons
            } catch let jsonError {
                print("Request error with response: \(jsonError)")
            }
        }
    }
}
