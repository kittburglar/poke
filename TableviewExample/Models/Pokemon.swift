//
//  Pokemon.swift
//  TableviewExample
//
//  Created by Kittiphong Xayasane on 2020-04-11.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

import Foundation

struct Pokemons: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Pokemon]?
}

struct Pokemon: Decodable {
    let name: String?
    let url: String?
}

