//
//  PokemonDetailsViewModel.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 18/06/2021.
//

import Foundation

class PokemonDetailsViewModel {
    
    // MARK: - Properties
    let pokemonListItem: PokemonListItem
    
    // MARK: - Init
    init(pokemonListItem: PokemonListItem) {
        self.pokemonListItem = pokemonListItem
    }
}
