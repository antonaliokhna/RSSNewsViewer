//
//  NewsModel.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import Foundation

struct RssModel: Codable {
    let channel: ChannelModel

    struct ChannelModel: Codable {
        let language: String
        let item: [NewsModel]
    }
}

struct NewsModel: Codable {
    //The main fields are optional because API can lag...
    let author: String?
    let title: String?
    let link: URL?
    let description: String?
    let pubDate: Date?
    let enclosure: Enclosure?
    let category: String?

    let viewed: Bool?
    let imageData: Data?

    struct Enclosure: Codable {
        let url: URL
    }

    func updateModel(imageData: Data? = nil, viewed: Bool? = nil) -> Self {
        return NewsModel(
            author: self.author,
            title: self.title,
            link: self.link,
            description: self.description,
            pubDate: self.pubDate,
            enclosure: self.enclosure,
            category: self.category,
            viewed: viewed ?? self.viewed,
            imageData: imageData ?? self.imageData
        )
    }
}

//MARK: Comparable

extension NewsModel: Comparable {
    static func < (lhs: NewsModel, rhs: NewsModel) -> Bool {
        guard let lhsDate = lhs.pubDate else { return true }
        guard let rhsDate = rhs.pubDate else { return false }
        return lhsDate < rhsDate
    }

    static func == (lhs: NewsModel, rhs: NewsModel) -> Bool {
        guard let lhsDate = lhs.pubDate, let rhsDate = rhs.pubDate else {
            return false
        }
        return lhsDate == rhsDate
    }

}
