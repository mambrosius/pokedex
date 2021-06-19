//
//  PokemonListAdapter.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 15/06/2021.
//

import UIKit

class PokemonListAdapter: NSObject {
    
    // MARK: - Delegate
    weak var delegate: PokemonListProtocol?
    
    // MARK: - Init
    init(delegate: PokemonListProtocol) {
        self.delegate = delegate
    }
    
    // MARK: - Utils
    func isMissingDataAt(_ indexPath: IndexPath) -> Bool {
        guard let currentNumberOfItems = delegate?.getCurrentNumberOfItems() else { return false }
        return indexPath.row >= currentNumberOfItems
    }
}

// MARK: - UITableViewDataSource
extension PokemonListAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.getTotalNumberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCell.identifier) as? PokemonCell else { fatalError() }
        
        if isMissingDataAt(indexPath) {
            // add shimmer
        } else if let item = delegate?.getItemAt(indexPath) {
            cell.pokemonLink = item
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

// MARK: - UITableViewDataSourcePrefetching
extension PokemonListAdapter: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let indexPath = indexPaths.last, isMissingDataAt(indexPath) else { return }
        delegate?.fetchNewItems()
    }
}

// MARK: - UITableViewDelegate
extension PokemonListAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        delegate?.itemSelectedAt(indexPath)
        return nil
    }
}
