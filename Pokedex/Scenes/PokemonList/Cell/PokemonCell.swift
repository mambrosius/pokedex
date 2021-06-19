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
        
        // Show:
        // - number
        // - image
        // - name
        // - type?
        
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    // MARK: - Update
    private func updateCell() {
        nameLabel.text = pokemonLink?.name
        idLabel.text = "\(pokemonLink?.id ?? .init())"
        
        if let pokemonId = pokemonLink?.id {
            pokemonImageView.kf.setImage(with: getImageUrlFor(pokemonId), options: [.transition(.fade(0.25))])
        } else {
            pokemonImageView.image = nil
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Utils
    func getImageUrlFor(_ id: Int) -> URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
    }
    
    // MARK: - Components
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(pokemonImageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(idLabel)
        return stackView
    }()
    
    lazy var pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
}
