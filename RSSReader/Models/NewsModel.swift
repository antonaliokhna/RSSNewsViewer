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
    let author: String
    let title: String
    let link: URL?
    let description: String
    let pubDate: Date
    let enclosure: Enclosure?
    let category: String

    let viewed: Bool?
    let imageData: Data?

    struct Enclosure: Codable {
        let url: URL
    }
}
