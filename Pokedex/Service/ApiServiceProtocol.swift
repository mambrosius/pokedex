//
//  ApiServiceProtocol.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 14/06/2021.
//

import Foundation

protocol ApiServiceProtocol: AnyObject {
    func fetchPokemons(_ nextPageUrl: URL?, completion: @escaping ApiServiceResult<PokemonListPage>)
    func fetchPokemon(_ url: URL, completion: @escaping ApiServiceResult<Pokemon>)
    func getArtworkUrlFor(_ id: Int) -> URL?
}
