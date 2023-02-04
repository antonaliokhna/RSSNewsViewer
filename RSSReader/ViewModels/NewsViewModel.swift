//
//  NewsViewModel.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import Foundation

final class NewsViewModel {
    private let networkService: NetworkDataServiceType = NetworkDataService()
    var reloable: Reloadable?

    private(set) var newsModels: [RssModel.NewsModel] = []
    private(set) var status: RequestStatuses = .loading {
        didSet {
            DispatchQueue.main.async {
                self.reloable?.reloadData()
            }
        }
    }
}


extension NewsViewModel {
    func loadNewsData() async {
        do {
            let model = try await self.networkService.fetchRssNews()

            self.newsModels = model.channel.item
            self.status = .sucsess


        } catch {
            guard let error = error as? CustomError else {
                self.status = .failed(error: .localError(error: .unknownError))

                return
            }
            self.status = .failed(error: error)
        }
    }
}
