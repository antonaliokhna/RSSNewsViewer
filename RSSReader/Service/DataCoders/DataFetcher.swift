//
//  DataFetcher.swift
//  PokemonApp
//
//  Created by Anton Aliokhna on 1/25/23.
//

import Foundation

final class DataFetcher: DataFetcherType {

    private let service: DataFetcherServiceType

    init(service: DataFetcherServiceType) {
        self.service = service
    }

    func fetchGenericData<T: Decodable>(
        url: String,
        parameters: Parameters
    ) async throws -> T {

        let data = try await service.fetch(
            from: url,
            parameters: parameters
        )

        return try self.decodeData(type: T.self, from: data)
    }

    private func decodeData<T: Decodable>(
        type: T.Type,
        from: Data?
    ) throws -> T {
        guard let data = from else {
            throw CustomError.codableError(error: .dataIsEmpty)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let object = try? decoder.decode(type, from: data) else {
            throw CustomError.codableError(error: .decodingDataFailed)
        }

        return object
    }
}
