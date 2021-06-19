//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 18/06/2021.
//

import UIKit
import RxSwift
import Kingfisher

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
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchPokemon()
    }
    
    // MARK: - Setup
    override func setupBindings() {
        super.setupBindings()
        
        viewModel.fetchedPokemon
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: updateView)
            .disposed(by: disposeBag)
        
        viewModel.errorMessage
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: presentErrorMessage)
            .disposed(by: disposeBag)
    }
    
    override func setupUI() {
        super.setupUI()
        title = viewModel.pokemonLink.name
        
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Show:
        // - Description
        // - number
        // - image
        // - name
        // - type
        // - weaknesses
        // - height
        // - weight
        // - category
        // - gender
        // - evolutions
    }
    
    // MARK: - Update
    func updateView(_ pokemon: Pokemon) {
        imageView.kf.setImage(with: viewModel.getArtworkUrlFor(pokemon.id), options: [
            .transition(.fade(0.25))
        ])
    }
    
    // MARK: - Components
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
}
