//
//  NewsCellViewModel.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/4/23.
//

import Foundation
import UIKit

final class NewsViewModel: ObservableObject, CellViewModelType {
    private let networkService: NetworkDataServiceType
    private let localService: LocalDataServiceType

    private(set) var newsModel: NewsModel {
        didSet {
            viewed = newsModel.viewed ?? false
            imageData = newsModel.imageData

            Task {
                await saveNewsModel()
                await updateUI()
            }
        }
    }

    private(set) var viewed: Bool
    private(set) var image: UIImage = .init(named: "no-image")!
    private(set) var imageData: Data?

    var reloableDelegate: Reloadable? {
        didSet {
            Task {
                await self.loadImage()
            }
        }
    }

    let author: String
    let title: String
    let description: String
    let pubDate: String
    let category: String
    let imageURL: URL?
    let link: URL?

    init(
        networkService: NetworkDataServiceType,
        localService: LocalDataServiceType,
        newsModel: NewsModel
    ) {
        self.networkService = networkService
        self.localService = localService
        self.newsModel = newsModel

        self.author = newsModel.author ?? "Without author"
        self.title = newsModel.title ?? "Without title"
        self.description = newsModel.description ?? "Without description"
        self.pubDate = newsModel.pubDate?.formatted() ?? "Without date"
        self.category = newsModel.category ?? "Without category"
        self.link = newsModel.link ?? URL(string: "https.")!
        self.imageURL = newsModel.enclosure?.url

        self.viewed = newsModel.viewed ?? false

        if let imageData = imageData, let image = UIImage(data: imageData) {
            self.image = image
            self.newsModel = newsModel.updateModel(
                imageData: imageData,
                viewed: viewed
            )
        }
    }

    @MainActor
    func setViewed(status: Bool) {
        newsModel = newsModel.updateModel(
            imageData: imageData,
            viewed: status
        )
    }

    @MainActor
    private func updateUI() {
        reloableDelegate?.reloadData()
    }
}

// MARK: Network service functions

extension NewsViewModel {
    func loadImage() async {
        guard
            let imageStringURL = imageURL?.absoluteString,
            imageData == nil else { return }
        do {
            let imageData = try await networkService.fetchImageData(
                stringURL: imageStringURL
            )

            guard let uiImage = UIImage(data: imageData) else { return }
            newsModel = newsModel.updateModel(imageData: imageData)
            image = uiImage
        } catch {
            // Some error...
        }
    }
}

// MARK: local service fucntions

extension NewsViewModel {

    private func saveNewsModel() async {
        do {
            try await localService.rewriteNewsBy(newNewsmodel: newsModel)
        } catch {
            // Some error..
        }
    }
}
