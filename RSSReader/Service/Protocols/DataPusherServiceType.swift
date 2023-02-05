//
//  DataPusherServiceType.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/5/23.
//

import Foundation

protocol DataPusherServiceType {
    func push(
        whereTo url: String,
        data: Data,
        parameters: Parameters
    ) async throws -> Data
}
