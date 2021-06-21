//
//  CollectionExtension.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 21/06/2021.
//

import Foundation

public extension Collection {
    
    /// Returns the element at the specified index if it is within the bounds, otherwise returns nil.
    subscript(safe index: Index) -> Iterator.Element? {
        indices.contains(index) ? self[index] : nil
    }
}
