//
//  CodableError.swift
//  PokemonApp
//
//  Created by Anton Aliokhna on 1/25/23.
//

import Foundation

enum CodableError: Error {
    case decodingDataFailed
    case encodingDataFailed
    case dataIsEmpty
}

//MARK: LocalizedError
extension CodableError: LocalizedError {
    var errorDescription: String? {
        var description: String
        switch self {
        case .decodingDataFailed:
            description = "Data decoding failed, "
        case .encodingDataFailed:
            description = "Data encoding failed, "
        case .dataIsEmpty:
            description = "Data is empty, "
        }
        description += "please contact the developer, or try again later..."

        return description
    }
}
