//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 14/06/2021.
//

import Foundation

class PokemonListViewModel {
    
    // MARK: - Properties
    let apiService: ApiServiceProtocol
    
    // MARK: - Init
    init(apiService: ApiServiceProtocol = ApiService()) {
        self.apiService = apiService
    }
}
