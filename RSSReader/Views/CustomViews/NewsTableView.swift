//
//  NewsTableView.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import Foundation
import UIKit

class NewsTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        self.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsCell")


        configure()

        //delegate = self
       // dataSource = self

        translatesAutoresizingMaskIntoConstraints = false

        estimatedRowHeight = 44

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        backgroundColor = .none
        translatesAutoresizingMaskIntoConstraints = false
    }

//    private func setUpDelegate() {
//        delegate = self
//    }
}





