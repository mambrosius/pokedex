//
//  ApiServiceError.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 14/06/2021.
//

import Foundation

enum ApiServiceError: Error {
    
    // MARK: - Cases
    case client(_ description: String)
    case server(_ description: String)
    case parser(_ description: String)
    case custom(_ description: String)
    
    // MARK: - Computed properties
    var description: String {
        switch self {
        case .client(let description):
            return description
        case .server(let description):
            return description
        case .parser(let description):
            return description
        case .custom(let description):
            return description
        }
    }
}
