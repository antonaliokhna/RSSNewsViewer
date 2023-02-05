//
//  LocalDataServiceType.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/5/23.
//

import Foundation

protocol LocalDataServiceType {
    func fetchNews() async throws -> [NewsModel]

    @discardableResult
    func saveNews(models: [NewsModel]) async throws -> Data

    @discardableResult
    func rewriteNewsBy(newNewsmodel: NewsModel) async throws -> Data
}
