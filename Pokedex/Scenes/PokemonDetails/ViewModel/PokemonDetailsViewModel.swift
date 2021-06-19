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
    let errorMessage = PublishSubject<String>()
    
    // MARK: - Init
    init(apiService: ApiServiceProtocol = ApiService(), pokemonLink: Link) {
        self.pokemonLink = pokemonLink
        super.init(apiService: apiService)
    }
    
    // MARK: - Api
    func fetchPokemon() {
        apiService.getPokemon(pokemonLink.url) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.errorMessage.onNext(error.description)
            case .success(let pokemon):
                self?.fetchedPokemon.onNext(pokemon)
            }
        }
    }
}
