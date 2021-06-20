//
//  Asset.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 20/06/2021.
//

import UIKit

struct Asset {
    struct Icon {
        static let arrowLeft = UIImage(named: "ic-arrow-left")
    }

    struct Color {
        static let grayBackground = UIColor(named: "gray-background")
        static let grayCardInner = UIColor(named: "gray-card-inner")
        static let grayCard = UIColor(named: "gray-card")
    }
    
    struct Font {
        static func medium(size: CGFloat) -> UIFont {
            UIFont(name: "HelveticaNeue-Medium", size: size)!
        }
        
        static func bold(size: CGFloat) -> UIFont {
            UIFont(name: "HelveticaNeue-Bold", size: size)!
        }
    }
}
