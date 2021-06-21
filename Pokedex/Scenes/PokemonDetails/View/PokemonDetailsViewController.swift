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
        
        viewModel.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: presentError)
            .disposed(by: disposeBag)
    }
    
    override func setupUI() {
        super.setupUI()
        
        view.addSubview(scrollView)
        scrollView.setConstraints([
            .top(anchor: view.topAnchor),
            .leading(anchor: view.leadingAnchor),
            .trailing(anchor: view.trailingAnchor),
            .bottom(anchor: view.bottomAnchor)
        ])
        
        scrollView.addSubview(stackView)
        stackView.setConstraints([
            .top(anchor: scrollView.topAnchor, constant: 10),
            .bottom(anchor: scrollView.bottomAnchor, constant: -32),
            .width(anchor: scrollView.widthAnchor, constant: -32),
            .centerX(anchor: scrollView.centerXAnchor)
        ])
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(nameCard)
        stackView.addArrangedSubview(typeCard)
        stackView.addArrangedSubview(statsCard)
        stackView.addArrangedSubview(infoCard)
        
        // Show:
        // - Description
        // - weaknesses
        // - gender
        // - evolutions
    }
    
    // MARK: - Update
    func updateView(_ pokemon: Pokemon) {
        idLabel.text = "#\(pokemon.id)"
        nameLabel.text = pokemon.name.uppercased()
        imageView.kf.setImage(with: viewModel.getArtworkUrlFor(pokemon.id), options: [
            .transition(.fade(0.25))
        ])
        
        pokemon.types.forEach {
            typeCard.addArrangedSubview(PokemonTypeView(type: $0))
        }
        
        pokemon.stats.forEach {
            statsCard.addArrangedSubview(StatView(title: $0.link.name, value: $0.baseStat, width: statsCard.contentWidth))
        }
        
        infoCard.addArrangedSubview(CardEntry(title: "height", value: "\(pokemon.heightString)"))
        infoCard.addArrangedSubview(CardEntry(title: "weight", value: "\(pokemon.weightString)"))
        
        UIView.animate(withDuration: 0.2) {
            self.stackView.alpha = 1
        }
    }
    
    // MARK: - Components
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, spacing: 20)
        stackView.alpha = 0
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(contentMode: .scaleAspectFit)
        imageView.setConstraints([.height(constant: 300)])
        return imageView
    }()
    
    private lazy var nameCard: Card = {
        let card = Card(margin: 10, stackView: .init(axis: .vertical, spacing: 2))
        card.addArrangedSubview(nameLabel)
        card.addArrangedSubview(idLabel)
        return card
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel(
            font: Asset.Font.bold(size: 22),
            color: UIColor.white.withAlphaComponent(0.8),
            textAlignment: .center
        )
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private lazy var idLabel: UILabel = {
        UILabel(
            font: Asset.Font.medium(size: 16),
            color: UIColor.white.withAlphaComponent(0.2),
            textAlignment: .center
        )
    }()
    
    private lazy var typeCard: Card = {
        Card(stackView: .init(axis: .horizontal, distribution: .fillEqually, spacing: 20))
    }()
    
    private lazy var statsCard: Card = {
        Card(stackView: .init(axis: .vertical, spacing: 20))
    }()
    
    private lazy var infoCard: Card = {
        Card(stackView: .init(axis: .vertical, spacing: 20))
    }()
}
