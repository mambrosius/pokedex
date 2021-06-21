//
//  ApiService.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 14/06/2021.
//

import Foundation

// MARK: - Typealias
typealias ApiServiceResult<T> = (Result<T, Error>) -> Void

// MARK: - ApiService
final class ApiService: ApiServiceProtocol {
    
    // MARK: - Properties
    private lazy var decoder: JSONDecoder = {
        JSONDecoder()
    }()
    
    // MARK: - ApiServiceProtocol
    func fetchPokemons(_ nextPageUrl: URL?, completion: @escaping ApiServiceResult<PokemonListPage>) {
        fetch(nextPageUrl?.absoluteString ?? "https://pokeapi.co/api/v2/pokemon", completion)
    }
    
    func fetchPokemon(_ url: URL, completion: @escaping ApiServiceResult<Pokemon>) {
        fetch(url.absoluteString, completion)
    }
    
    // MARK: - Utils
    func getArtworkUrlFor(_ id: Int) -> URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")
    }
    
    private func fetch<T: Decodable>(_ urlString: String, _ completion: @escaping ApiServiceResult<T>) {
        guard let url = URL(string: urlString) else { fatalError("Failed to parse string to URL: \(urlString)") }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let response = try self.decoder.decode(T.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(CustomError(errorDescription: "No data")))
            }
        }.resume()
    }
}
