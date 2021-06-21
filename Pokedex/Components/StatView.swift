//
//  StatView.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 21/06/2021.
//

import UIKit

class StatView: UIStackView {
    
    // MARK: - Properties
    let title: String
    let value: Int
    
    // MARK: - Init
    init(title: String, value: Int, width: CGFloat) {
        self.title = title
        self.value = value
        super.init(frame: .init(x: 0, y: 0, width: width, height: 0))
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        spacing = 0
        axis = .vertical
        
        let stackView = UIStackView(axis: .horizontal, spacing: 0)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
        
        addArrangedSubview(stackView)
        addArrangedSubview(lineChart)
        setConstraints([.height(constant: 30)])
    }
    
    // MARK: - Components
    private lazy var titleLabel: UILabel = {
        UILabel(
            text: title.uppercased(),
            font: Asset.Font.medium(size: 14),
            color: UIColor.white.withAlphaComponent(0.5)
        )
    }()
    
    private lazy var valueLabel: UILabel = {
        UILabel(
            text: "\(value)/255",
            font: Asset.Font.medium(size: 14),
            color: UIColor.white.withAlphaComponent(0.2),
            textAlignment: .right
        )
    }()
    
    private lazy var lineChart: UIStackView = {
        let stackView = UIStackView(axis: .horizontal, spacing: 0)
        stackView.setConstraints([.height(constant: 2)])
        stackView.addArrangedSubview(filledSegment)
        stackView.addArrangedSubview(unfilledSegment)
        return stackView
    }()
    
    private lazy var filledSegment: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        view.setConstraints([.width(constant: frame.size.width * (CGFloat(value) / 255))])
        return view
    }()
    
    private lazy var unfilledSegment: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Color.grayCardInner
        return view
    }()
}
