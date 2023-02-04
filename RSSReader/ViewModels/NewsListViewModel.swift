//
//  NewsViewModel.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import Foundation

final class NewsListViewModel {
    private let networkService: NetworkDataService = NetworkDataService()
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

// MARK: async load functions
extension NewsListViewModel {
    func loadNewsData() async {

        do {
            let model = try await self.networkService.fetchRssNews()

            var tempViewModels: [NewsViewModel] = []
            model.channel.item.forEach { newsModel in
                if !newsViewModels.contains(where: { newsViewModel in
                    newsViewModel.title == newsModel.title
                }) {
                    tempViewModels.append(NewsViewModel(newsModel: newsModel))
                    //newsViewModels.insert(NewsViewModel(newsModel: newsModel), at: 0)
                }
            }

            tempViewModels.append(contentsOf: newsViewModels)

            newsViewModels = tempViewModels
            DispatchQueue.main.async {
                self.reloable?.reloadData()
            }
            //self.status = .sucsess

        } catch {
            print(error.localizedDescription)
            guard let error = error as? CustomError else {
                self.status = .failed(error: .localError(error: .unknownError))

                return
            }
            self.status = .failed(error: error)
        }
    }
}
