//
//  PokemonTableViewCellViewModel.swift
//  TableviewExample
//
//  Created by Kittiphong Xayasane on 2020-04-12.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

import Foundation

struct PokemonItemViewModel {
    let pokemon: Pokemon
    let name: String
    let url: String
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        name = pokemon.name
        url = pokemon.url
    }
}
