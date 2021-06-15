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
    func getPokemons(completion: @escaping ApiServiceResult<PokemonListPage>) {
        get("https://pokeapi.co/api/v2/pokemon", completion: completion)
    }
    
    // MARK: - Utils
    func get<T: Decodable>(_ url: String, completion: @escaping ApiServiceResult<T>) {
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
