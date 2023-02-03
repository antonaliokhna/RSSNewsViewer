//
//  ViewController.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import UIKit

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

        setUpViews()
        makeConstraints()
    }

    private func setUpViews() {
        //view.addSubview(label)
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

