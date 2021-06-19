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
        let label = UILabel(text: title)
        label.textColor = .white
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel(text: value)
        label.textAlignment = .right
        label.textColor = .white
        return label
    }()
}
