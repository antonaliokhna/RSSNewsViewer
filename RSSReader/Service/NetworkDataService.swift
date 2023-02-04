//
//  NetworkDataService.swift
//  PokemonApp
//
//  Created by Anton Aliokhna on 1/25/23.
//

import Foundation

final class NetworkDataService {

    private let xmlFetcher: DataFetcherType

    init(
        xmlFetcher: DataFetcherType = XMLDataFetcher(
            service: AlamofireNetworkService()
        )
    ) {
        self.xmlFetcher = xmlFetcher
    }
}

//MARK: NetworkDataServiceType
extension NetworkDataService: NetworkDataServiceType {

    func fetchRssNews() async throws -> RssModel {
        let newsUrl = "https://lenta.ru/rss/news"
        return try await xmlFetcher.fetchGenericData(
            url: newsUrl,
            parameters: [:]
        )
    }
}
