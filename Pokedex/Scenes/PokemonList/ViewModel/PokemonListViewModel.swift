//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 14/06/2021.
//

import Foundation

class PokemonListViewModel {
    
    // MARK: - Constants
    let apiService: ApiServiceProtocol
    
    // MARK: - Variables
    private var pokemonListItems = [PokemonListItem]()
    
    // MARK: - Init
    init(apiService: ApiServiceProtocol = ApiService()) {
        self.apiService = apiService
    }
    
    // MARK: - Api
    func fetchPokemons() {
        apiService.getPokemons { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.description)
            case .success(let pokemonListPage):
                self?.pokemonListItems = pokemonListPage.results
            }
        }
    }
}
