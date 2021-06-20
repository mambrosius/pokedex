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
    private var searchText = String()
    private var pokemonLinks = [Link]()
    private var searchedPokemonLinks = [Link]()
    
    // MARK: - Observables
    let reloadData = PublishSubject<Bool>()
    let indexPathsToReload = PublishSubject<[IndexPath]>()
    let showLoadingIndicator = PublishSubject<Bool>()
    let errorMessage = PublishSubject<String>()
    
    // MARK: - Computed properties
    var links: [Link] {
        searchText.isEmpty ? pokemonLinks : searchedPokemonLinks
    }
    
    var currentNumberOfItems: Int {
        links.count
    }
    
    var totalNumberOfItems: Int {
        searchText.isEmpty ? currentPage?.count ?? 0 : searchedPokemonLinks.count
    }
    
    var hasMoreToFetch: Bool {
        guard let currentPage = currentPage else { return true }
        return currentPage.count > pokemonLinks.count
    }
    
    // MARK: - Api
    func fetchPokemonLinks() {
        guard !isFetching else { return }
        
        isFetching = true
        apiService.getPokemons(currentPage?.next) { [weak self] result in
            self?.isFetching = false
            switch result {
            case .failure(let error):
                self?.errorMessage.onNext(error.description)
            case .success(let pokemonListPage):
                self?.currentPage = pokemonListPage
                self?.pokemonLinks.append(contentsOf: pokemonListPage.results)
                
                if let searchText = self?.searchText, !searchText.isEmpty {
                    self?.performSearch(searchText)
                } else {
                    guard let newIndexPaths = self?.getIndexPathsToReloadFor(pokemonListPage.results) else { return }
                    self?.indexPathsToReload.onNext(newIndexPaths)
                }
            }
            
            self?.showLoadingIndicator.onNext(false)
        }
    }
    
    // MARK: - Utils
    func getItemAt(_ indexPath: IndexPath) -> Link? {
        return links.get(indexPath.row)
    }
    
    private func getIndexPathsToReloadFor(_ newListItems: [Link]) -> [IndexPath] {
        let startIndex = currentNumberOfItems - newListItems.count
        let endIndex = startIndex + newListItems.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    func performSearch(_ searchText: String? = nil) {
        if let searchText = searchText {
            self.searchText = searchText.lowercased()
        }
        
        searchedPokemonLinks = pokemonLinks.filter {
            $0.name.contains(self.searchText) || "\(String(describing: $0.id))".contains(self.searchText)
        }
        
        reloadData.onNext(true)
        if hasMoreToFetch {
            fetchPokemonLinks()
        }
    }
}
