//
//  ApiService.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 14/06/2021.
//

import Foundation

// MARK: - Typealias
typealias ApiServiceResult<T> = (Result<T, ApiServiceError>) -> Void

// MARK: - ApiService
class ApiService: ApiServiceProtocol {
    
    // MARK: - Properties
    lazy var decoder: JSONDecoder = {
        JSONDecoder()
    }()
    
    // MARK: - ApiServiceProtocol
    func getPokemons(_ nextPageUrl: URL?, completion: @escaping ApiServiceResult<PokemonListPage>) {
        get(nextPageUrl?.absoluteString ?? "https://pokeapi.co/api/v2/pokemon", completion)
    }
    
    func getPokemon(_ url: URL, completion: @escaping ApiServiceResult<Pokemon>) {
        get(url.absoluteString, completion)
    }
    
    // MARK: - Utils
    func getArtworkUrlFor(_ id: Int) -> URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")
    }
    
    private func get<T: Decodable>(_ url: String, _ completion: @escaping ApiServiceResult<T>) {
        guard let url = URL(string: url) else {
            completion(.failure(.client("Invalid url")))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(.server(error.localizedDescription)))
            } else if let data = data {
                do {
                    let response = try self.decoder.decode(T.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.parser(error.localizedDescription)))
                }
            } else {
                completion(.failure(.server("No data")))
            }
        }.resume()
    }
}
