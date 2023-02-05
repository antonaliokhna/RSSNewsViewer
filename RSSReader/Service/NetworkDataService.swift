//
//  NetworkDataService.swift
//  PokemonApp
//
//  Created by Anton Aliokhna on 1/25/23.
//

import Foundation

final class NetworkDataService {
    private let xmlFetcher: DataFetcherType
    private let dataFetcher: DataFetcherType

    init(
        xmlFetcher: DataFetcherType = XMLDataFetcher(
            service: AlamofireNetworkService()
        ),
        dataFetcher: DataFetcherType = DataFetcher(
            service: AlamofireNetworkService()
        )
    ) {
        self.xmlFetcher = xmlFetcher
        self.dataFetcher = dataFetcher
    }
}

// MARK: NetworkDataServiceType

extension NetworkDataService: NetworkDataServiceType {
    func fetchRssNews() async throws -> RssModel {
        let newsUrl = "https://lenta.ru/rss/news"

        return try await xmlFetcher.fetchGenericData(
            url: newsUrl,
            parameters: [:]
        )
    }

    func fetchImageData(stringURL: String) async throws -> Data {
        return try await dataFetcher.fetchGenericData(
            url: stringURL,
            parameters: [:]
        )
    }
}
