//
//  NetworkError.swift
//  PokemonApp
//
//  Created by Anton Aliokhna on 1/25/23.
//

import Foundation

enum NetworkError: Error {
    case requestFailed(statusCode: Int?)
    case internetConnectionFailed
    case requestTimeOut
    case invalidURL
}

//MARK: LocalizedError
extension NetworkError: LocalizedError {
    var errorDescription: String? {
        let description: String
        switch self {
        case .requestFailed(let statusCode):
            description = "Request execution error (\(statusCode ?? 418)). Please try again later, or contact the developer."
        case .invalidURL:
            description = "Error when trying to execute a link request. Please contact the developer."
        case .requestTimeOut:
            description = "The request has exceeded the time allowed. Please try again later."
        case .internetConnectionFailed:
            description = "There is no internet connection. Please check the connection and restart the application."
        }

        return description
    }
}
