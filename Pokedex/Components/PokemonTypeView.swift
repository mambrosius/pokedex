//
//  PokemonTypeView.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 21/06/2021.
//

import UIKit

class PokemonTypeView: Card {
    
    // MARK: - Properties
    let type: Type
    
    // MARK: - Init
    init(type: Type) {
        self.type = type
        super.init(
            color: Asset.Color.pokemonType(type.link.id)?.withAlphaComponent(0.8), cornerRadius: 10,
            margin: 5, stackView: .init(axis: .horizontal, spacing: 5)
        )
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        addArrangedSubview(label)
    }
    
    // MARK: - Components
    private lazy var label: UILabel = {
        let label = UILabel(
            text: type.link.name.uppercased(),
            font: Asset.Font.bold(size: 14),
            color: UIColor.white.withAlphaComponent(0.8),
            textAlignment: .center
        )
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
}
