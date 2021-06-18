//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 18/06/2021.
//

import UIKit

class PokemonDetailsViewController: BaseViewController {
    
    // MARK: - Properties
    let viewModel: PokemonDetailsViewModel
    
    // MARK: - Init
    init(viewModel: PokemonDetailsViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    override func setupBindings() {
        super.setupBindings()
    }
    
    override func setupUI() {
        super.setupUI()
        title = viewModel.pokemonListItem.name
    }
}
