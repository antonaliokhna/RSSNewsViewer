//
//  ViewController.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import SnapKit
import SwiftUI
import UIKit

final class NewsViewController: UIViewController {
    private let newsTableView: NewsTableView = .init(
        frame: .zero,
        style: .plain
    )
    private let refreshControl = UIRefreshControl()

    private let viewModel: NewsListViewModel = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "News"

        setUpViews()
        makeConstraints()
        setTableviewDelegateAndDataSourse()
        setTableViewRefrechControl()
        setViewModelDelegate()

        loadViewModelData()
    }

    private func loadViewModelData() {
        Task {
            await viewModel.loadNewsData()
        }
    }
}

// MARK: Reloadable

extension NewsViewController: Reloadable {
    func reloadData() {
        newsTableView.reloadData()
    }
}

// MARK: UITableViewDelegate

extension NewsViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let viewModel = viewModel.getNewsViewModel(at: indexPath)
        let datailNewsView = DetailNewsView(viewModel: viewModel)

        tableView.deselectRow(at: indexPath, animated: true)

        navigationController?.pushViewController(
            UIHostingController(rootView: datailNewsView),
            animated: true
        )
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 100
    }

    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        let transform
            = CATransform3DTranslate(CATransform3DIdentity, 0, -50, 0)

        cell.layer.transform = transform
        cell.alpha = 0.1

        UIView.animate(withDuration: 0.3) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
}

// MARK: UITableViewDataSource

extension NewsViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.newsViewModels.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "newsCell",
            for: indexPath
        ) as? NewsTableViewCell else { return UITableViewCell() }

        let viewModel = viewModel.getNewsViewModel(at: indexPath)
        cell.setViewModel(viewModel: viewModel)

        return cell
    }
}

// MARK: refreshControll

extension NewsViewController {
    private func setTableViewRefrechControl() {
        refreshControl.attributedTitle = NSAttributedString(
            string: "Pull to refresh"
        )
        refreshControl.addTarget(
            self,
            action: #selector(refresh),
            for: .valueChanged
        )
        newsTableView.refreshControl = refreshControl
    }

    @objc private func refresh() {
        loadViewModelData()

        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
}

// MARK: setupVideDelegates

extension NewsViewController {
    private func setTableviewDelegateAndDataSourse() {
        newsTableView.dataSource = self
        newsTableView.delegate = self
    }

    private func setViewModelDelegate() {
        viewModel.reloable = self
    }
}

// MARK: setupView

extension NewsViewController {
    private func makeConstraints() {
        newsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setUpViews() {
        view.addSubview(newsTableView)
    }
}
