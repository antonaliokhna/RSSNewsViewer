//
//  ViewController.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .red
        label.text = "empty label"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let newsTableView: NewsTableView = NewsTableView(frame: .zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        title = "News"
        newsTableView.dataSource = self
        newsTableView.delegate = self

        setUpViews()
        makeConstraints()
    }

    private func setUpViews() {
        view.addSubview(newsTableView)
    }
}


//Constraints
extension ViewController {
    private func makeConstraints() {
//        NSLayoutConstraint.activate([
//            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//        ])

        NSLayoutConstraint.activate([
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTableView.topAnchor.constraint(equalTo: view.topAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

}

extension ViewController: UITableViewDelegate {

}


extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(UIHostingController(rootView: DetailNewsView()), animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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

