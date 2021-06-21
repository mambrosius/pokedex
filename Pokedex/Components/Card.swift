//
//  Card.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 19/06/2021.
//

import UIKit

class Card: UIView {
    
    // MARK: - Properties
    private let margin: CGFloat
    private let stackView: UIStackView
    
    // MARK: - ComputedProperties
    var contentWidth: CGFloat {
        stackView.frame.size.width
    }
    
    // MARK: - Init
    init(color: UIColor? = Asset.Color.grayCard, cornerRadius: CGFloat = 20, margin: CGFloat = 20, stackView: UIStackView = UIStackView(axis: .horizontal, spacing: 20)) {
        self.margin = margin
        self.stackView = stackView
        
        super.init(frame: .zero)
        setup(color: color, cornerRadius: cornerRadius)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup(color: UIColor?, cornerRadius: CGFloat) {
        backgroundColor = color
        layer.cornerRadius = cornerRadius
                
        addSubview(stackView)
        stackView.setConstraints([
            .top(anchor: topAnchor, constant: margin),
            .leading(anchor: leadingAnchor, constant: margin),
            .trailing(anchor: trailingAnchor, constant: -margin),
            .bottom(anchor: bottomAnchor, constant: -margin)
        ])
    }
    
    // MARK: - Utils
    func addArrangedSubview(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }
}
