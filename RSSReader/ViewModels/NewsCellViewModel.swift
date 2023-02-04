//
//  NewsCellViewModel.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/4/23.
//

import Foundation
import UIKit

struct NewsCellViewModel {
    let imageURL: URL?
    let title: String
    let pubDate: String
    private let viewed: Bool = false
}
