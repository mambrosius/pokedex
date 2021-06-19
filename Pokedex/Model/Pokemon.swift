//
//  Pokemon.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 18/06/2021.
//

import Foundation

struct Pokemon: Decodable {
    
    // MARK: - Properties
    let id: Int
    let name: String
    let types: [Type]
    let stats: [Stat]
    let weight: Int
    let height: Int
}
