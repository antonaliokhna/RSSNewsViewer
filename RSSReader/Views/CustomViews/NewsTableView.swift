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

        delegate = self
        dataSource = self

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

extension NewsTableView: UITableViewDelegate {

}

extension NewsTableView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.dequeueReusableCell(
            withIdentifier: "newsCell",
            for: indexPath
        ) as? NewsTableViewCell else { return UITableViewCell() }

        cell.title.text = "Abubus news"
        cell.descriptionLabel.text = "Abubus news Abubus news Abub, constant: -16, constant: -16, constant: -16us news Abubus news Abubus news"
        cell.dateCreate.text = "11.09.2012"

        return cell
    }

}

