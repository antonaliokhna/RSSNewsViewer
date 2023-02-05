//
//  NewsViewModel.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import Foundation

final class NewsListViewModel {
    private let networkService: NetworkDataService = NetworkDataService()
    private let localDataService: LocalDataService = LocalDataService()

    var reloable: Reloadable?

    private(set) var newsViewModels: [NewsViewModel] = []

    private(set) var status: RequestStatuses = .loading {
        didSet {
            DispatchQueue.main.async {
                self.reloable?.reloadData()
            }
        }
    }

    func getNewsViewModel(at indexPath: IndexPath) -> NewsViewModel {
        let news = newsViewModels[indexPath.row]

        return news
    }
}

// MARK: async network load functions
extension NewsListViewModel {
    func loadNewsData() async {

        if let loadedModels = try? await loadLocalNewsModelData(), newsViewModels.isEmpty {
            self.newsViewModels = loadedModels.map { NewsViewModel(newsModel: $0) }
            print(self.newsViewModels.count)
        }


        do {
            let model = try await self.networkService.fetchRssNews()

            var tempViewModels: [NewsViewModel] = []
            model.channel.item.forEach { newsModel in
                if !newsViewModels.contains(where: { newsViewModel in
                    newsViewModel.title == newsModel.title
                }) {
                    tempViewModels.append(NewsViewModel(newsModel: newsModel))
                }
            }

            tempViewModels.append(contentsOf: newsViewModels)

            newsViewModels = tempViewModels

            try await localDataService.saveNews(
                models: newsViewModels.map { $0.getCurrentModel() }
            )
            //self.status = .sucsess

        } catch {
            print(error.localizedDescription)
            guard let error = error as? CustomError else {
                self.status = .failed(error: .localError(error: .unknownError))

                return
            }
            self.status = .failed(error: error)
        }

        DispatchQueue.main.async {
            self.reloable?.reloadData()
        }
    }
}

// MARK: async local load data fucntions
extension NewsListViewModel {
    func loadLocalNewsModelData() async throws -> [NewsModel] {
        return try await localDataService.fetchNews()
    }
}
