//
//  CustomError.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 21/06/2021.
//

import Foundation

struct CustomError: Error, LocalizedError {
    var errorDescription: String?
}
