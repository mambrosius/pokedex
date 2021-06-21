//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 15/06/2021.
//

import UIKit
import Kingfisher

class PokemonCell: UITableViewCell {

    // MARK: - Properties
    var pokemonLink: Link? {
        didSet { updateCell() }
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonLink = nil
    }
    
    // MARK: - Setup
    private func setup() {
        backgroundColor = .clear
        
        contentView.addSubview(card)
        card.setConstraints([
            .top(anchor: contentView.topAnchor, constant: 16),
            .leading(anchor: contentView.leadingAnchor, constant: 16),
            .trailing(anchor: contentView.trailingAnchor, constant: -16),
            .bottom(anchor: contentView.bottomAnchor)
        ])
        
        card.addSubview(identifierLabel)
        identifierLabel.setConstraints([
            .top(anchor: card.topAnchor, constant: 20),
            .trailing(anchor: card.trailingAnchor, constant: -20)
        ])
        
        let imageContainer = Card(
            color: Asset.Color.grayCardInner, cornerRadius: 10, margin: 5,
            stackView: .init(axis: .vertical, spacing: 0)
        )
        
        imageContainer.addArrangedSubview(pokemonImageView)
        imageContainer.setConstraints([
            .height(constant: 64),
            .width(constant: 64)
        ])
        
        card.addArrangedSubview(imageContainer)
        card.addArrangedSubview(nameLabel)
    }
    
    // MARK: - Update
    private func updateCell() {
        nameLabel.text = pokemonLink?.name.uppercased()
        identifierLabel.text = "#\(pokemonLink?.id ?? .init())"
        
        if let pokemonId = pokemonLink?.id {
            pokemonImageView.kf.setImage(with: getImageUrlFor(pokemonId), options: [.transition(.fade(0.25))])
        } else {
            pokemonImageView.image = nil
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        
    }
    
    // MARK: - Utils
    func getImageUrlFor(_ id: Int) -> URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
    }
    
    // MARK: - Components
    private lazy var card: Card = {
        Card()
    }()
        
    private lazy var pokemonImageView: UIImageView = {
        UIImageView(contentMode: .scaleAspectFit)
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel(
            font: Asset.Font.medium(size: 22),
            color: UIColor.white.withAlphaComponent(0.8)
        )
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var identifierLabel: UILabel = {
        UILabel(
            font: Asset.Font.bold(size: 10),
            color: UIColor.white.withAlphaComponent(0.6),
            textAlignment: .center
        )
    }()
}
