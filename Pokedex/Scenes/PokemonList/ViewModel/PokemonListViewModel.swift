//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 14/06/2021.
//

import Foundation
import RxSwift

class PokemonListViewModel: BaseViewModel {
    
    // MARK: - Variables
    private var isFetching = false
    private var currentPage: PokemonListPage?
    private var pokemonLinks = [Link]()
    
    // MARK: - Observables
    let showLoadingIndicator = PublishSubject<Bool>()
    let errorMessage = PublishSubject<String>()
    let indexPathsToReload = PublishSubject<[IndexPath]>()
    
    // MARK: - Computed properties
    var totalNumberOfItems: Int {
        currentPage?.count ?? 0
    }
    
    var currentNumberOfItems: Int {
        pokemonLinks.count
    }
    
    // MARK: - Api
    func fetchPokemonLinks() {
        guard !isFetching else { return }
        
        isFetching = true
        apiService.getPokemons(currentPage?.next) { [weak self] result in
            switch result {
            case .failure(let error):
                self?.errorMessage.onNext(error.description)
            case .success(let pokemonListPage):
                self?.currentPage = pokemonListPage
                self?.pokemonLinks.append(contentsOf: pokemonListPage.results)
                guard let newIndexPaths = self?.getIndexPathsToReloadFor(pokemonListPage.results) else { return }
                self?.indexPathsToReload.onNext(newIndexPaths)
            }
            
            self?.isFetching = false
            self?.showLoadingIndicator.onNext(false)
        }
    }
    
    // MARK: - Utils
    func getItemAt(_ indexPath: IndexPath) -> Link? {
        return pokemonLinks.get(indexPath.row)
    }
    
    private func getIndexPathsToReloadFor(_ newListItems: [Link]) -> [IndexPath] {
        let startIndex = currentNumberOfItems - newListItems.count
        let endIndex = startIndex + newListItems.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
