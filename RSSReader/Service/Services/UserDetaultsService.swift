//
//  UserDetaultsService.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/5/23.
//

import Foundation

final class UserDetaultsService: ServiceType {
    typealias ServiceType = UserDefaults
    let service: ServiceType = UserDefaults.standard

    func push(
        whereTo url: String,
        data: Data,
        parameters: Parameters
    ) async throws -> Data {
        service.set(data, forKey: url)

        return data
    }

    func fetch(
        from url: String,
        parameters: Parameters
    ) async throws -> Data? {
        return service.data(forKey: url)
    }
}
