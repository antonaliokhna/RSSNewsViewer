//
//  NewsCellViewModel.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/4/23.
//

import Foundation
import UIKit

final class NewsViewModel: ObservableObject {
    private let networkService: NetworkDataService
    private let localService: LocalDataService
    let newsModel: NewsModel

    var reloableDelegate: Reloadable? {
        didSet {
            Task {
                await self.loadImage()
            }
        }
    }

    var author: String
    var title: String
    var description: String
    var pubDate: String
    var category: String
    var image: UIImage

    var link: URL?
    var imageURL: URL?

    var imageData: Data?
    var viewed: Bool

    init(
        networkService: NetworkDataService,
        localService: LocalDataService,
        newsModel: NewsModel
    ) {
        self.networkService = networkService
        self.localService = localService

        self.newsModel = newsModel

        self.author = newsModel.author
        self.title = newsModel.title
        self.description = newsModel.description
        self.pubDate = newsModel.pubDate.formatted()
        self.category = newsModel.category
        self.link = newsModel.link
        self.imageURL = newsModel.enclosure?.url

        self.imageData = newsModel.imageData
        self.viewed = newsModel.viewed ?? false

        if let imageData = imageData {
            self.image = UIImage(data: imageData)!
        } else {
            self.image = UIImage(named: "img")!
        }
    }

    func getCurrentModel() -> NewsModel {
        print("new NewsModel")
        return NewsModel(
            author: self.author,
            title: self.title,
            link: self.link,
            description: self.description,
            pubDate: newsModel.pubDate,
            enclosure: self.newsModel.enclosure,
            category: self.category,
            viewed: self.viewed,
            imageData: self.imageData
        )
    }

    func setViewed() {
        viewed = true

        Task {
            try await localService.rewriteNewsBy(newNewsmodel: getCurrentModel())
        }

        reloableDelegate?.reloadData()
    }
}

extension NewsViewModel {
    func loadImage() async {
        //костыль
        guard let imageURL = imageURL, imageData == nil else { return }
        
        do {
            let imageData = try await self.networkService.fetchImageData(
                stringURL: imageURL.absoluteString
            )

            guard let image = UIImage(data: imageData) else { return }
            self.imageData = imageData
            self.image = image

            DispatchQueue.main.async {
            
                self.reloableDelegate?.reloadData()
            }

        } catch {
//            guard let error = error as? CustomError else {
//                self.status = .failed(error: .localError(error: .unknownError))
//
//                return
//            }
//            self.status = .failed(error: error)
        }

        print("dispatch")

        DispatchQueue.main.async {
            self.reloableDelegate?.reloadData()
        }
    }
}
