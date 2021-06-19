//
//  StatEntry.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 18/06/2021.
//

import Foundation

struct Stat: Decodable {
    let baseStat: Int
    let effort: Int
    let stat: Link
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}
