//
//  PokemonListPage.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 14/06/2021.
//

import Foundation

struct PokemonListPage: Decodable {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [Link]
}
