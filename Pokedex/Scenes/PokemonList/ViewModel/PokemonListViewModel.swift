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
    private var isFetching = false
    private var currentPage: PokemonListPage?
    private var pokemonListItems = [PokemonListItem]()
    
    // MARK: - Observables
    let showLoadingIndicator = PublishSubject<Bool>()
    let errorMessage = PublishSubject<String>()
    let indexPathsToReload = PublishSubject<[IndexPath]>()
    
    // MARK: - Computed properties
    var totalNumberOfItems: Int {
        currentPage?.count ?? 0
    }
    
    var currentNumberOfItems: Int {
        pokemonListItems.count
    }
    
    // MARK: - Init
    init(apiService: ApiServiceProtocol = ApiService()) {
        self.apiService = apiService
    }
    
    // MARK: - Api
    func fetchPokemons() {
        guard !isFetching else { return }
        
        isFetching = true
        apiService.getPokemons(currentPage?.next) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.errorMessage.onNext(error.description)
            case .success(let pokemonListPage):
                self?.currentPage = pokemonListPage
                self?.pokemonListItems.append(contentsOf: pokemonListPage.results)
                guard let newIndexPaths = self?.getIndexPathsToReloadFor(pokemonListPage.results) else { return }
                self?.indexPathsToReload.onNext(newIndexPaths)
            }
            
            self?.isFetching = false
            self?.showLoadingIndicator.onNext(false)
        }
    }
    
    // MARK: - Utils
    func getItemAt(_ indexPath: IndexPath) -> PokemonListItem? {
        return pokemonListItems.get(indexPath.row)
    }
    
    private func getIndexPathsToReloadFor(_ newListItems: [PokemonListItem]) -> [IndexPath] {
        let startIndex = currentNumberOfItems - newListItems.count
        let endIndex = startIndex + newListItems.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
