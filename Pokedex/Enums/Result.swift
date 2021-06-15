//
//  ApiServiceResult.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 14/06/2021.
//

import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}
