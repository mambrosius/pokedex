//
//  Type.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 18/06/2021.
//

import Foundation

struct Type: Decodable {
    let slot: Int
    let link: Link
    
    enum CodingKeys: String, CodingKey {
        case slot
        case link = "type"
    }
}
