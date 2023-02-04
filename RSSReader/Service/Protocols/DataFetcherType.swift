//
//  DataFetcherType.swift
//  PokemonApp
//
//  Created by Anton Aliokhna on 1/25/23.
//

import Foundation

protocol DataFetcherType {
    func fetchGenericData<T: Decodable>(
        url: String,
        parameters: Parameters
    ) async throws -> T
}
