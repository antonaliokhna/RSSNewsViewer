//
//  LocalDataServiceType.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/5/23.
//

import Foundation

protocol LocalDataServiceType {
    func saveNews(models: [NewsModel]) async throws -> Data
    func fetchNews() async throws -> [NewsModel]
    func rewriteNewsBy(newNewsmodel: NewsModel) async throws -> Data
}
