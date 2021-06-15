//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 14/06/2021.
//

import UIKit

class PokemonListViewController: UIViewController {

    // MARK: - Properties
    lazy var viewModel: PokemonListViewModel = {
        PokemonListViewModel()
    }()
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchPokemons()
    }
    
    // MARK: - Setup
    private func setup() {
        view.addSubview(label)
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    // MARK: - Components
    lazy var label: UILabel = {
        let label = UILabel(text: "Welcome to Pokédex")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
