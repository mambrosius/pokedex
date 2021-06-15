//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 14/06/2021.
//

import Foundation
import RxSwift

class PokemonListViewModel {
    
    // MARK: - Constants
    let apiService: ApiServiceProtocol
    
    // MARK: - Variables
    private var currentPage: PokemonListPage?
    
    // MARK: - Observables
    let isLoading = PublishSubject<Bool>()
    let errorMessage = PublishSubject<String>()
    let pokemonListItems = BehaviorSubject<[PokemonListItem]>(value: .init())
    
    // MARK: - Computed properties
    var numberOfItems: Int {
        guard let numberOfItems = try? pokemonListItems.value().count else { return 0 }
        return numberOfItems
    }
    
    // MARK: - Init
    init(apiService: ApiServiceProtocol = ApiService()) {
        self.apiService = apiService
    }
    
    // MARK: - Api
    func fetchPokemons() {
        isLoading.onNext(true)
        apiService.getPokemons { [weak self] result in
            switch result {
            case .failure(let error):
                self?.errorMessage.onNext(error.description)
            case .success(let pokemonListPage):
                self?.currentPage = pokemonListPage
                self?.pokemonListItems.onNext(pokemonListPage.results)
            }
            self?.isLoading.onNext(false)
        }
    }
    
    // MARK: - Utils
    func getItemAt(_ indexPath: IndexPath) -> PokemonListItem {
        guard let item = try? pokemonListItems.value()[indexPath.row] else { fatalError() }
        return item
    }
}
