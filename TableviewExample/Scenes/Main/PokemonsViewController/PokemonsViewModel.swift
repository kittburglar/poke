//
//  DetailListViewModel.swift
//  TableviewExample
//
//  Created by Kittiphong Xayasane on 2020-04-10.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

import Foundation

class PokemonsViewModel {
    //MARK: - Model object
    //Private to seperate view from model
    private let networkService: NetworkService?
    private var pokemons: Pokemons? {
        didSet {
            self.fetchCompletionHandler?()
        }
    }
    private var pokemonCellViewModels: [PokemonItemViewModel] = [PokemonItemViewModel]() {
        didSet {
            DispatchQueue.main.async {
                self.dataRefreshHandler?()
            }
        }
    }
    
    // MARK: - Property Getters
    var numberOfCells: Int {
        return pokemonCellViewModels.count
    }
    
    func getViewModel(forIndexPath indexPath: IndexPath) -> PokemonItemViewModel {
        return pokemonCellViewModels[indexPath.row]
    }
    
    // MARK: - State properties
    var isLoading: Bool = false {
        didSet {
            self.startedFetchHandler?()
        }
    }
    
    
    // MARK: - Binding closures
    var startedFetchHandler: (()->())?
    var fetchCompletionHandler: (()->())?
    var dataRefreshHandler: (()->())?
    
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
        var pokemonViewModels: [PokemonItemViewModel] = [PokemonItemViewModel]()
        pokemons.results?.forEach({ (pokemon) in
            pokemonViewModels.append(createViewModel(pokemon: pokemon))
        })
        
        pokemonCellViewModels = pokemonViewModels
    }
    
    // Create view model from pokemon model
    func createViewModel(pokemon: Pokemon) -> PokemonItemViewModel {
        return PokemonItemViewModel(pokemon: pokemon)
    }
}
