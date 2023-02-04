//
//  CustomError.swift
//  PokemonApp
//
//  Created by Anton Aliokhna on 1/25/23.
//

import Foundation

enum CustomError: Error {
    case networkError(error: NetworkError)
    case localError(error: LocalError)
    case codableError(error: CodableError)
}

//MARK: LocalizedError
extension CustomError: LocalizedError {
    var errorDescription: String? {
        let description: String?
        switch self {
        case .networkError(let error):
            description = error.errorDescription
        case .codableError(let error):
            description = error.errorDescription
        case .localError(let error):
            description = error.errorDescription
        }

        return description
    }
}

//MARK: Getting error image name
extension CustomError {
    var errorImageName: String {
        let imagePath: String
        switch self {
        case .networkError:
            imagePath = "wifi.slash"
        case .codableError:
            imagePath = "network"
        case .localError:
            imagePath = "exclamationmark.triangle"
        }

        return imagePath
    }
}
