//
//  UIImageViewExtension.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 20/06/2021.
//

import UIKit

extension UIImageView {
    convenience init(contentMode: UIView.ContentMode) {
        self.init()
        self.contentMode = contentMode
    }
}
