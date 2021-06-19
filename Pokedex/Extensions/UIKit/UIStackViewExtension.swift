//
//  UIStackViewExtension.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 19/06/2021.
//

import UIKit

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution = .fill, spacing: CGFloat) {
        self.init()
        self.axis = axis
        self.distribution = distribution
        self.spacing = spacing
    }
}
