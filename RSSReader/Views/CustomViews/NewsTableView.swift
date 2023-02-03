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
        self.scrollIndicatorInsets = UIEdgeInsets(top: 44.0, left: 0.0, bottom: 0.0, right: 0.0);

        //delegate = self
       // dataSource = self


        translatesAutoresizingMaskIntoConstraints = false

        estimatedRowHeight = 44

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {

        sectionHeaderTopPadding = 5
       //backgroundColor = .green
        translatesAutoresizingMaskIntoConstraints = false
    }

//    private func setUpDelegate() {
//        delegate = self
//    }
}





