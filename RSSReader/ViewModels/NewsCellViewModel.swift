//
//  NewsCellViewModel.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/4/23.
//

import Foundation
import UIKit

class NewsCellViewModel {
    private let networkService: NetworkDataService = NetworkDataService()

    let imageURL: String?
    let title: String
    let pubDate: String
    private let viewed: Bool = false

    var image: UIImage?

    init(imageURL: String?, title: String, pubDate: String) {
        self.imageURL = imageURL
        self.title = title
        self.pubDate = pubDate

        print("55555")

        if let imageURL = imageURL {

            Task {
                let data = try await networkService.fetchImageData(stringURL: imageURL)
                image = UIImage(data: data)
            }
        }
    }
}

extension NewsCellViewModel {
    func loadImage(url: URL) {

    }
}
