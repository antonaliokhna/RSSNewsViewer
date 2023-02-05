//
//  DataPusherType.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/5/23.
//

import Foundation

protocol DataPusherType {
    func pushGenericValue<T: Encodable>(
        url: String,
        value: T,
        parameters: Parameters
    ) async throws -> Data
}
