//
//  Card.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 19/06/2021.
//

import UIKit

class Card: UIView {
    
    // MARK: - Properties
    private let contentAxis: NSLayoutConstraint.Axis
    
    // MARK: - Init
    init(color: UIColor? = Color.grayCard, cornerRadius: CGFloat = 20, contentAxis: NSLayoutConstraint.Axis) {
        self.contentAxis = contentAxis
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
            .top(anchor: topAnchor, constant: 20),
            .leading(anchor: leadingAnchor, constant: 20),
            .trailing(anchor: trailingAnchor, constant: -20),
            .bottom(anchor: bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Components
    lazy var stackView: UIStackView = {
        UIStackView(axis: contentAxis, spacing: 20)
    }()
}
