//
//  XMLDataFetcher.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import Foundation
import XMLParsing

final class XMLDataFetcher: NSObject, DataFetcherType {
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

        let decoder = XMLDecoder()

        let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE, dd MMM YYYY HH:mm:ss"
            return formatter
        }()
        decoder.dateDecodingStrategy = .formatted(formatter)

        guard let object = try? decoder.decode(T.self, from: data) else {
            throw CustomError.codableError(error: .decodingDataFailed)
        }

        return object
    }
}
