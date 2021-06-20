//
//  CardEntry.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 19/06/2021.
//

import UIKit

class CardEntry: UIStackView {
    
    // MARK: - Properties
    let title: String
    let value: String
    
    // MARK: - Init
    init(title: String, value: String) {
        self.title = title
        self.value = value
        super.init(frame: .zero)
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup() {
        axis = .horizontal
        spacing = 10
        setConstraints([.height(constant: 30)])
        addArrangedSubview(titleLabel)
        addArrangedSubview(valueLabel)
    }
    
    // MARK: - Components
    lazy var titleLabel: UILabel = {
        UILabel(
            text: title,
            font: Asset.Font.bold(size: 14),
            color: UIColor.white.withAlphaComponent(0.8)
        )
    }()
    
    lazy var valueLabel: UILabel = {
        UILabel(
            text: value,
            font: Asset.Font.medium(size: 14),
            color: UIColor.white.withAlphaComponent(0.5),
            textAlignment: .right
        )
    }()
}
