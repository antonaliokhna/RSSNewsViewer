//
//  ViewController.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import UIKit
import SwiftUI

final class NewsViewController: UIViewController {
    private let newsTableView: NewsTableView = NewsTableView(frame: .zero, style: .plain)
    private let networkDataService: NetworkDataServiceType = NetworkDataService()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"

        setUpViews()
        setConstraints()
        setTableviewDelegateAndDataSourse()

        Task {
            print("sda")
            if let model = try? await networkDataService.fetchRssNews() {
                print(model)
            } else {
                print("error")
            }
        }
    }

    private func setUpViews() {
        view.addSubview(newsTableView)
    }

    private func setTableviewDelegateAndDataSourse() {
        newsTableView.dataSource = self
        newsTableView.delegate = self
    }
}


//Constraints
extension NewsViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}

extension NewsViewController: UITableViewDelegate {

}


extension NewsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 5
    }

    func numberOfSections(in tableView: UITableView) -> Int {
           return 10
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(UIHostingController(rootView: DetailNewsView()), animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "newsCell",
            for: indexPath
        ) as? NewsTableViewCell else { return UITableViewCell() }

        cell.title.text = "Abubus news"
        cell.descriptionLabel.text = "Abubus news Abubus news Abub, constant: -16, constant: -16, constant: -16us news Abubus news Abubus news"
        cell.dateCreate.text = "11.09.2012"

        return cell
    }

}

