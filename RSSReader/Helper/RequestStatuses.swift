//
//  RequestStatuses.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/4/23.
//

import Foundation

enum RequestStatuses {
    case failed(error: CustomError)
    case sucsess
    case loading
}

// MARK: Equatable

extension RequestStatuses: Equatable {
    static func == (lhs: RequestStatuses, rhs: RequestStatuses) -> Bool {
        lhs.value == rhs.value
    }

    private var value: String? {
        return String(describing: self).components(separatedBy: "(").first
    }
}
