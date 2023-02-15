//
//  NewsListViewModel.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import Foundation

final class NewsListViewModel {
    private let networkService: NetworkDataServiceType = NetworkDataService()
    private let localService: LocalDataServiceType = LocalDataService()

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
        status = .loading

        if newsViewModels.count <= 0 {
            await loadAndSetLocalNewsModels()
        }

        do {
            let models = try await networkService.fetchRssNews()
            var tempViewModels: [NewsViewModel] = []

            models.channel.item.forEach { newNewsModels in
                if !newsViewModels.contains(
                    where: { $0.title == newNewsModels.title }
                ) {
                    let newsViewModel = NewsViewModel(
                        networkService: networkService,
                        localService: localService,
                        newsModel: newNewsModels
                    )

                    tempViewModels.append(newsViewModel)
                }
            }

            let countNewElements = tempViewModels.count
            tempViewModels.append(contentsOf: newsViewModels)
            tempViewModels.sort(by: { $0.newsModel > $1.newsModel })

            if newsViewModels.count >= countNewElements {
                tempViewModels = tempViewModels.dropLast(countNewElements)
            }
            newsViewModels = tempViewModels

            await saveLocalNewsModelData()

            status = .sucsess
        } catch {
            guard let error = error as? CustomError else {
                status = .failed(error: .localError(error: .unknownError))

                return
            }

            guard newsViewModels.count <= 0 else {
                status = .sucsess

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
        guard let loadedModels = try? await localService.fetchNews(),
              newsViewModels.isEmpty else { return }

        newsViewModels = loadedModels.map {
            NewsViewModel(
                networkService: networkService,
                localService: localService,
                newsModel: $0
            )
        }
    }

    private func saveLocalNewsModelData() async {
        do {
            try await localService.saveNews(
                models: newsViewModels.map { $0.newsModel }
            )
        } catch {
            // Some saving error...
        }
    }
}
