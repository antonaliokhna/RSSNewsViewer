//
//  NetworkDataServiceType.swift
//  PokemonApp
//
//  Created by Anton Aliokhna on 1/28/23.
//

import Foundation

protocol NetworkDataServiceType {
    func fetchRssNews() async throws -> RssModel
    func fetchImageData(stringURL: String) async throws -> Data
}
