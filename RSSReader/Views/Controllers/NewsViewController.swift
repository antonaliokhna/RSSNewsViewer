//
//  ViewController.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import UIKit
import SwiftUI

protocol Reloadable {
    func reloadData()
}

final class NewsViewController: UIViewController {
    private let newsTableView: NewsTableView = NewsTableView(frame: .zero, style: .plain)

    private let viewModel: NewsViewModel = NewsViewModel()

    let refreshControl = UIRefreshControl()


    @objc func refresh(_ sender: AnyObject) {
        Task {
            try? await viewModel.loadNewsData()
            refreshControl.endRefreshing()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"

        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        newsTableView.refreshControl = refreshControl
        // newsTableView.addSubview(refreshControl) // not required when using UITableViewController

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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }

}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let datail = DetailNewsView(viewModel: DetailNewsViewModel(autor: "Дарья Коршунова", title: "Месси пожаловался на «убивавших» его на чемпионате мира-2022 журналистов", description: "<![CDATA[Капитан сборной Аргентины Лионель Месси рассказал о давлении со стороны журналистов во время чемпионата мира-2022 в Катаре. «Я думаю, люди видели все, с чем я боролся, пытаясь достичь этой цели, думаю, что то, с чем я столкнулся в сборной Аргентины, показалось многим людям несправедливым», — сказал он.]]>", pubDate: "Fri, 03 Feb 2023 14:24:00 +0300", image: UIImage(named: "img")!, caterogy: "Спорт", link: URL(string: "https://lenta.ru/news/2023/02/03/piotr_pavel")!))
        navigationController?.pushViewController(UIHostingController(rootView: datail), animated: true)
    }
}


extension NewsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "newsCell",
            for: indexPath
        ) as? NewsTableViewCell else { return UITableViewCell() }


        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellViewModel

        return cell
    }

    //animation
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let rotationTransform = CATransform3DTranslate (CATransform3DIdentity, -100, -10, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0.5

        UIView.animate (withDuration: 0.5) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
}

