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

    func getCellViewModel(at indexPath: IndexPath) -> NewsViewModel {
        print(newsViewModels.count)
        let news = newsViewModels[indexPath.row]

        return news
    }
}

// MARK: async load functions
extension NewsListViewModel {
    func loadNewsData() async {

        print("dsa")
        do {
            let model = try await self.networkService.fetchRssNews()
            //print("dsa")

            let newModels = model.channel.item.map { model in
                NewsViewModel(newsModel: model)
            }

            //let aboba =

            self.newsViewModels = newModels
            self.status = .sucsess

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
