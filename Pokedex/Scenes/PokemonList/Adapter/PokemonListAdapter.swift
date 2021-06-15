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
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension PokemonListAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.getNumberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCell.identifier) as? PokemonCell,
              let item = delegate?.getItemAt(indexPath) else { fatalError() }
        cell.nameLabel.text = item.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        delegate?.itemSelectedAt(indexPath)
        return nil
    }
}
