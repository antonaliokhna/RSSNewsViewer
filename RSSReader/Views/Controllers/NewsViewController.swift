//
//  ViewController.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import UIKit
import SwiftUI
import SnapKit

final class NewsViewController: UIViewController {

    private let newsTableView: NewsTableView = NewsTableView(
        frame: .zero,
        style: .plain
    )
    private let refreshControl = UIRefreshControl()

    private let viewModel: NewsListViewModel = NewsListViewModel()

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
        makeConstraints()
        setTableviewDelegateAndDataSourse()

        loadViewModelData()
    }

    private func setUpViews() {
        view.addSubview(newsTableView)
    }

    private func setTableviewDelegateAndDataSourse() {
        newsTableView.dataSource = self
        newsTableView.delegate = self
    }

    private func loadViewModelData() {
        Task {
            await viewModel.loadNewsData()
        }
    }

    @objc private func refresh(_ sender: AnyObject) {
        loadViewModelData()
        refreshControl.endRefreshing()
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
        
        navigationController?.pushViewController(
            UIHostingController(rootView: datailNewsView),
            animated: true
        )

        viewModel.setViewed()
        viewModel.reloable?.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let rotationTransform = CATransform3DTranslate (CATransform3DIdentity, 0, -60, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0.1

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
    private func makeConstraints() {
        newsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}



