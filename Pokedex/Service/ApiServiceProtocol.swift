//
//  ApiServiceProtocol.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 14/06/2021.
//

import Foundation

protocol ApiServiceProtocol: AnyObject {
    func getPokemons(_ nextPageUrl: URL?, completion: @escaping ApiServiceResult<PokemonListPage>)
}
