//
//  ArrayExtension.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 16/06/2021.
//

import Foundation

extension Array {
    
    /// Safe way of accessing elements of an array.
    /// - Parameter index: The index of the desired element.
    /// - Returns: The element at the index. Returns nil if the index is out of bounds.
    func get(_ index: Int) -> Element? {
        guard 0 <= index && index < count else { return nil }
        return self[index]
    }
}
