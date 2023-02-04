//
//  LocalError.swift
//  PokemonApp
//
//  Created by Anton Aliokhna on 1/25/23.
//

import Foundation

enum LocalError: Error {
    case unknownError
}

//MARK: LocalizedError
extension LocalError: LocalizedError {
    var errorDescription: String? {
        let description: String
        switch self {
        case .unknownError:
            description = "Unknown error. :((( \nTry restart application."
        }

        return description
    }
}
