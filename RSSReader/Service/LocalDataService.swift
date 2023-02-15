//
//  LocalDataService.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/5/23.
//

import Foundation
import Semaphore

final class LocalDataService {
    private let dataFetcher: DataFetcherType
    private let dataPusher: DataPusherType

    private let semaphore = AsyncSemaphore(value: 1)

    init(
        dataPusher: DataPusherType = DataPusher(
            service: UserDetaultsService()
        ),
        dataFetcher: DataFetcherType = DataFetcher(
            service: UserDetaultsService()
        )
    ) {
        self.dataFetcher = dataFetcher
        self.dataPusher = dataPusher
    }
}

// MARK: LocalDataServiceType

extension LocalDataService: LocalDataServiceType {
    func fetchNews() async throws -> [NewsModel] {
        return try await dataFetcher.fetchGenericData(
            url: "news",
            parameters: [:]
        )
    }

    @discardableResult
    func saveNews(models: [NewsModel]) async throws -> Data {
        return try await dataPusher.pushGenericValue(
            url: "news",
            value: models,
            parameters: [:]
        )
    }

    @discardableResult
    func rewriteNewsBy(newNewsmodel: NewsModel) async throws -> Data {
        await semaphore.wait()

        var news = try await fetchNews()
        news = news.map { newsModel in
            if newNewsmodel.title == newsModel.title {
                return newNewsmodel
            } else {
                return newsModel
            }
        }

        defer {
            semaphore.signal()
        }

        return try await saveNews(models: news)
    }
}
