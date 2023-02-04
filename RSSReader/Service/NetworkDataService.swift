//
//  NetworkDataService.swift
//  PokemonApp
//
//  Created by Anton Aliokhna on 1/25/23.
//

import Foundation
import UIKit

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

//MARK: NetworkDataServiceType
extension NetworkDataService: NetworkDataServiceType {

    func fetchRssNews() async throws -> RssModel {
        let newsUrl = "https://lenta.ru/rss/news"
        return try await xmlFetcher.fetchGenericData(
            url: newsUrl,
            parameters: [:]
        )
    }

    func fetchImageData(stringURL: String) async throws -> Data {
        //let stringURL = "https://icdn.lenta.ru/images/2023/02/03/14/20230203140524680/pic_556d87ea4360ddd3edda9fa5f6f00452.jpeg"
        
        return try await dataFetcher.fetchGenericData(
            url: stringURL,
            parameters: [:]
        )
    }
}
