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
    private var pokemonCellViewModels: [PokemonTableViewCellViewModel] = [PokemonTableViewCellViewModel]() {
        didSet {
            DispatchQueue.main.async {
                self.refreshTableView?()
            }
        }
    }
    
    // MARK: - Property Getters
    var numberOfCells: Int {
        return pokemonCellViewModels.count
    }
    
    func getViewModel(forIndexPath indexPath: IndexPath) -> PokemonTableViewCellViewModel {
        return pokemonCellViewModels[indexPath.row]
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
    var refreshTableView: (()->())?
    
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
                let pokemonsModel = try JSONDecoder().decode(Pokemons.self, from: data)
                self.processPokemon(pokemonsModel)
                
            } catch let jsonError {
                print("Request error with response: \(jsonError)")
            }
        }
    }
    
    func processPokemon(_ pokemons: Pokemons) {
        self.pokemons = pokemons //Cache
        var pokemonViewModels: [PokemonTableViewCellViewModel] = [PokemonTableViewCellViewModel]()
        pokemons.results?.forEach({ (pokemon) in
            pokemonViewModels.append(createViewModel(pokemon: pokemon))
        })
        
        pokemonCellViewModels = pokemonViewModels
    }
    
    // Create view model from pokemon model
    func createViewModel(pokemon: Pokemon) -> PokemonTableViewCellViewModel {
        return PokemonTableViewCellViewModel(name: pokemon.name, url: pokemon.url)
    }
}
