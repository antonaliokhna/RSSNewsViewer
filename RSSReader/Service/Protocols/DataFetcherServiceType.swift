//
//  DataFetcherServiceType.swift
//  PokemonApp
//
//  Created by Anton Aliokhna on 1/25/23.
//

import Foundation

protocol DataFetcherServiceType {
    func fetch(
        from url: String,
        parameters: Parameters
    ) async throws -> Data
}
