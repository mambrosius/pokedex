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
        
        // swiftlint:disable:next cyclomatic_complexity function_body_length
        static func pokemonType(_ type: Int?) -> UIColor? {
            let typeUnknown = UIColor(named: "type-unknown")
            guard let type = type else { return typeUnknown }
            switch type {
            case 1:
                return UIColor(named: "type-normal")
            case 2:
                return UIColor(named: "type-fighting")
            case 3:
                return UIColor(named: "type-flying")
            case 4:
                return UIColor(named: "type-poison")
            case 5:
                return UIColor(named: "type-ground")
            case 6:
                return UIColor(named: "type-rock")
            case 7:
                return UIColor(named: "type-bug")
            case 8:
                return UIColor(named: "type-ghost")
            case 9:
                return UIColor(named: "type-steel")
            case 10:
                return UIColor(named: "type-fire")
            case 11:
                return UIColor(named: "type-water")
            case 12:
                return UIColor(named: "type-grass")
            case 13:
                return UIColor(named: "type-electric")
            case 14:
                return UIColor(named: "type-psychic")
            case 15:
                return UIColor(named: "type-ice")
            case 16:
                return UIColor(named: "type-dragon")
            case 17:
                return UIColor(named: "type-dark")
            case 18:
                return UIColor(named: "type-fairy")
            case 19:
                return typeUnknown
            case 20:
                return UIColor(named: "type-shadow")
            default:
                return typeUnknown
            }
        }
    }
    
    struct Font {
        static func regular(size: CGFloat) -> UIFont {
            UIFont(name: "HelveticaNeue", size: size)!
        }
        
        static func medium(size: CGFloat) -> UIFont {
            UIFont(name: "HelveticaNeue-Medium", size: size)!
        }
        
        static func bold(size: CGFloat) -> UIFont {
            UIFont(name: "HelveticaNeue-Bold", size: size)!
        }
    }
}
