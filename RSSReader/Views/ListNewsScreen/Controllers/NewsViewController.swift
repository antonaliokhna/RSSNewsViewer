//
//  ViewController.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import SkeletonView
import SnapKit
import SwiftUI
import UIKit

private struct Constants {
    struct Cell {
        static let startAlpha: CGFloat = 0.1
        static let endAlpha: CGFloat = 1
        static let animationDuration: CGFloat = 0.3
    }
    static let skeletonCrossDissolve: CGFloat = 0.25
    static let cellTransform = CATransform3DTranslate(
        CATransform3DIdentity, 0, -50, 0
    )
}

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

        startSkeletonAnimation()
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
        if case RequestStatuses.failed(let error) = viewModel.status {
            CustomAlertController.showAlert(
                vc: self,
                title: error.localizedDescription,
                customActions: [
                    .init(title: "Reload", style: .default) { _ in
                        self.loadViewModelData()
                    }
                ]
            )
        } else {
            newsTableView.reloadData()
            stopSkeletonAnimation()
        }
    }
}

// MARK: SkeletonAnimation

extension NewsViewController {
    private func startSkeletonAnimation() {
        newsTableView.isSkeletonable = true
        newsTableView.showGradientSkeleton(
            usingGradient: .init(baseColor: .lightGray),
            animated: true,
            delay: .zero,
            transition: .crossDissolve(Constants.skeletonCrossDissolve)
        )
    }

    private func stopSkeletonAnimation() {
        newsTableView.stopSkeletonAnimation()
        view.hideSkeleton(
            reloadDataAfter: true,
            transition: .crossDissolve(Constants.skeletonCrossDissolve)
        )
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
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        let transform = Constants.cellTransform

        cell.layer.transform = transform
        cell.alpha = Constants.Cell.startAlpha

        UIView.animate(withDuration: Constants.Cell.animationDuration) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = Constants.Cell.endAlpha
        }
    }
}

// MARK: SkeletonTableViewDataSource(UITableViewDataSource)

extension NewsViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(
        _ skeletonView: UITableView,
        cellIdentifierForRowAt indexPath: IndexPath
    ) -> ReusableCellIdentifier {
        return NewsTableViewCell.identifier
    }

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
            withIdentifier: NewsTableViewCell.identifier,
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
        viewModel.reloableDelegate = self
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
