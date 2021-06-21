//
//  Link.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 18/06/2021.
//

import Foundation

struct Link: Decodable {
    let name: String
    let url: URL
    
    var id: Int? {
        guard let lastPathComponent = url.pathComponents.last else { return nil }
        return Int(lastPathComponent)
    }
}
