//
//  PokemonDetailsViewModel.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 18/06/2021.
//

import Foundation
import RxSwift

class PokemonDetailsViewModel: BaseViewModel {
    
    // MARK: - Properties
    let pokemonLink: Link
    
    // MARK: - Observables
    let showLoadingIndicator = PublishSubject<Bool>()
    let fetchedPokemon = PublishSubject<Pokemon>()
    let error = PublishSubject<Error>()
    
    // MARK: - Init
    init(apiService: ApiServiceProtocol = ApiService(), pokemonLink: Link) {
        self.pokemonLink = pokemonLink
        super.init(apiService: apiService)
    }
    
    // MARK: - Api
    func fetchPokemon() {
        apiService.fetchPokemon(pokemonLink.url) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.error.onNext(error)
            case .success(let pokemon):
                self?.fetchedPokemon.onNext(pokemon)
            }
        }
    }
}
