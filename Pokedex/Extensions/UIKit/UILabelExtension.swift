//
//  UILabelExtension.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 14/06/2021.
//

import UIKit

extension UILabel {
    
    // MARK: - Init
    convenience init(text: String? = nil, font: UIFont, color: UIColor, textAlignment: NSTextAlignment = .left, numberOfLines: Int = 1) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = color
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
}
