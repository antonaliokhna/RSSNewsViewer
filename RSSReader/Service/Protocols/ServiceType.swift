//
//  ServiceType.swift
//  PokemonApp
//
//  Created by Anton Aliokhna on 1/25/23.
//

import Foundation

protocol ServiceType: DataFetcherServiceType {
    associatedtype ServiceType
    var service: ServiceType { get }
}
