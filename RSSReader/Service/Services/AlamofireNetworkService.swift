//
//  AlamofireNetworkService.swift
//  PokemonApp
//
//  Created by Anton Aliokhna on 1/25/23.
//

import Foundation
import Alamofire

final class AlamofireNetworkService: ServiceType {

    typealias ServiceType = Session
    let service: ServiceType = {
        let configuration = AF.sessionConfiguration
        configuration.timeoutIntervalForRequest = 5

        return Session(configuration: configuration)
    }()

    func fetch(from url: String, parameters: Parameters) async throws -> Data {
        guard let url = URL(string: url) else {
            throw CustomError.networkError(error: .invalidURL)
        }

        let request = createRequest(request: url, parameters: parameters)
        request.resume()

        let result = await request.serializingData().result
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw CustomError.networkError(error: error.convertToNetworkError)
        }
    }

    private func createRequest(
        request: URLConvertible,
        parameters: Parameters
    ) -> DataRequest {
        return service
            .request(request, parameters: parameters)
            .validate()
    }
}
