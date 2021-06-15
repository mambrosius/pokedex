//
//  PokemonListProtocol.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 15/06/2021.
//

import Foundation

protocol PokemonListProtocol: AnyObject {
    func getItemAt(_ indexPath: IndexPath) -> PokemonListItem
    func itemSelectedAt(_ indexPath: IndexPath)
    func getNumberOfItems() -> Int
}
