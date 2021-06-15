//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 14/06/2021.
//

import Foundation

protocol PokemonListViewModelDelegate: AnyObject {
    func updateSpinner(_ isLoading: Bool)
    func showErrorMessage(_ message: String)
    func reloadTableView()
}

class PokemonListViewModel {
    
    // MARK: - Constants
    let apiService: ApiServiceProtocol
    
    // MARK: - Delegate
    weak var delegate: PokemonListViewModelDelegate?
    
    // MARK: - Variables
    private var currentPage: PokemonListPage?
    private var pokemonListItems = [PokemonListItem]() {
        didSet {
            delegate?.reloadTableView()
        }
    }
    
    private var isLoading = false {
        didSet {
            delegate?.updateSpinner(isLoading)
        }
    }
    
    // MARK: - Computed properties
    var numberOfItems: Int {
        pokemonListItems.count
    }
    
    // MARK: - Init
    init(apiService: ApiServiceProtocol = ApiService(), delegate: PokemonListViewModelDelegate) {
        self.apiService = apiService
        self.delegate = delegate
    }
    
    // MARK: - Api
    func fetchPokemons() {
        isLoading = true
        apiService.getPokemons { [weak self] result in
            switch result {
            case .failure(let error):
                self?.delegate?.showErrorMessage(error.description)
            case .success(let pokemonListPage):
                self?.currentPage = pokemonListPage
                self?.pokemonListItems = pokemonListPage.results
            }
            self?.isLoading = false
        }
    }
    
    // MARK: - Utils
    func getItemAt(_ indexPath: IndexPath) -> PokemonListItem {
        return pokemonListItems[indexPath.row]
    }
}
