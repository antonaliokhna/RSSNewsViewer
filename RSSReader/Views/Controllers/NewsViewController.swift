//
//  ViewController.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import UIKit
import SwiftUI

final class NewsViewController: UIViewController {

    private let newsTableView: NewsTableView = NewsTableView(
        frame: .zero,
        style: .plain
    )

    private let viewModel: NewsListViewModel = NewsListViewModel()

    private let refreshControl = UIRefreshControl()

    @objc private func refresh(_ sender: AnyObject) {
        Task {
            try? await viewModel.loadNewsData()
            refreshControl.endRefreshing()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"

        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(
            self,
            action: #selector(self.refresh(_:)),
            for: .valueChanged
        )

        newsTableView.refreshControl = refreshControl

        viewModel.reloable = self

        setUpViews()
        setConstraints()
        setTableviewDelegateAndDataSourse()

        Task {
            try? await viewModel.loadNewsData()
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

extension NewsViewController: Reloadable {
    func reloadData() {
        newsTableView.reloadData()
    }
}

//MARK: UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = viewModel.getNewsViewModel(at: indexPath)
        let datailNewsView = DetailNewsView(viewModel: viewModel)
        
        navigationController?.pushViewController(UIHostingController(rootView: datailNewsView), animated: true)
        viewModel.viewed = true
        viewModel.reloable?.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let rotationTransform = CATransform3DTranslate (CATransform3DIdentity, 0, -60, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0.5

        UIView.animate (withDuration: 0.5) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
}

// MARK: UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "newsCell",
            for: indexPath
        ) as? NewsTableViewCell else { return UITableViewCell() }


        let viewModel = viewModel.getNewsViewModel(at: indexPath)
        cell.setViewModel(viewModel: viewModel)

        return cell
    }
}

// MARK: setConstraints
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



