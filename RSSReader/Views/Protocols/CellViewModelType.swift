//
//  CellViewModelType.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/6/23.
//

import Foundation
import UIKit

protocol CellViewModelType: AnyObject {
    var reloableDelegate: Reloadable? { get set }
    var image: UIImage { get }
    var title: String { get }
    var pubDate: String { get }
    var viewed: Bool { get }
}
