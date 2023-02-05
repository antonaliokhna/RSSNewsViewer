//
//  NewsViewModel.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import Foundation

final class NewsListViewModel {
    private let networkService: NetworkDataService = .init()
    private let localDataService: LocalDataService = .init()

    private(set) var newsViewModels: [NewsViewModel] = []
    private(set) var status: RequestStatuses = .loading

    var reloableDelegate: Reloadable?

    func getNewsViewModel(at indexPath: IndexPath) -> NewsViewModel {
        let news = newsViewModels[indexPath.row]

        return news
    }

    @MainActor
    private func updateUI() {
        reloableDelegate?.reloadData()
    }
}

// MARK: Network service functions

extension NewsListViewModel {
    func loadNewsData() async {
        await loadAndSetLocalNewsModels()

        do {
            let models = try await networkService.fetchRssNews()
            var tempViewModels: [NewsViewModel] = []

            models.channel.item.forEach { newsModel in
                if !newsViewModels.contains(
                    where: { $0.title == newsModel.title }
                ) {
                    tempViewModels.append(
                        NewsViewModel(
                            networkService: networkService,
                            localService: localDataService,
                            newsModel: newsModel
                        )
                    )
                    // To avoid a warning
                    _ = newsViewModels.popLast()
                }
            }
            tempViewModels.append(contentsOf: newsViewModels)
            newsViewModels = tempViewModels
            status = .sucsess

            await saveLocalNewsModelData()
        } catch {
            guard let error = error as? CustomError else {
                status = .failed(error: .localError(error: .unknownError))

                return
            }
            status = .failed(error: error)
        }

        await updateUI()
    }
}

// MARK: Local service functions

extension NewsListViewModel {
    private func loadAndSetLocalNewsModels() async {
        guard let loadedModels = try? await localDataService.fetchNews(),
              newsViewModels.isEmpty else { return }

        newsViewModels = loadedModels.map {
            NewsViewModel(
                networkService: networkService,
                localService: localDataService,
                newsModel: $0
            )
        }
    }

    private func saveLocalNewsModelData() async {
        do {
            try await localDataService.saveNews(models: newsViewModels.map { $0.newsModel })
        } catch {
            // Some saving error...
        }
    }
}
