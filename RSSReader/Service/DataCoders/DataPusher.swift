//
//  DataPusher.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/5/23.
//

import Foundation

final class DataPusher: DataPusherType {

    private let service: DataPusherServiceType

    init(service: DataPusherServiceType) {
        self.service = service
    }

    func pushGenericValue<T: Encodable>(
        url: String,
        value: T,
        parameters: Parameters
    ) async throws -> Data {
        let data = try encodeData(from: value)

        return try await service.push(
            whereTo: url,
            data: data,
            parameters: parameters
        )
    }

    private func encodeData<T: Encodable>(from: T) throws -> Data {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(from) else {
            throw CodableError.encodingDataFailed
        }

        return data
    }
}
