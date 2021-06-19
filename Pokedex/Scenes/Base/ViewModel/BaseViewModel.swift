//
//  BaseViewModel.swift
//  Pokedex
//
//  Created by Morten Ambrosius Andreasen on 19/06/2021.
//

import Foundation

class BaseViewModel {
    
    // MARK: - Constants
    let apiService: ApiServiceProtocol
    
    // MARK: - Init
    init(apiService: ApiServiceProtocol = ApiService()) {
        self.apiService = apiService
    }
    
    // MARK: - Utils
    func getArtworkUrlFor(_ id: Int) -> URL? {
        return apiService.getArtworkUrlFor(id)
    }
}
