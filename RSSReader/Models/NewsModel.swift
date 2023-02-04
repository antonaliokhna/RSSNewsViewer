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

    struct NewsModel: Codable {
        let author: String
        let title: String
        let description: String
        let pubDate: String
        let enclosure: Enclosure?
        let category: String

        struct Enclosure: Codable {
            let url: String
        }
    }
}

