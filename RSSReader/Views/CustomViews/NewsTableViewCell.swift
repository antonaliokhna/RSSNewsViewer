//
//  NewsTableViewCell.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import Foundation
import UIKit

final class NewsTableViewCell: UITableViewCell {
    private let contentImageView: UIImageView = {
        let image = UIImageView(image: nil)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 16

        return image
    }()

    private let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize: 16, weight: .bold)
        title.numberOfLines = 3

        return title
    }()

    private let datePubLabel: UILabel = {
        let date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.font = .systemFont(ofSize: 14, weight: .light)

        return date
    }()

    private let viewedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .light)

        return label
    }()

    private weak var viewModel: NewsViewModel? {
        didSet {
            viewModel?.reloableDelegate = self
            reloadData()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUpViews()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setViewModel(viewModel: NewsViewModel) {
        self.viewModel = viewModel
    }

}

// MARK: private updated view functions

extension NewsTableViewCell {
    private func updateContent(viewModel: NewsViewModel) {
        contentImageView.image = viewModel.image
        titleLabel.text = viewModel.title
        datePubLabel.text = viewModel.pubDate

        setViewedStyle(viewed: viewModel.viewed)
    }

    private func setViewedStyle(viewed: Bool) {
        if viewed {
            viewedLabel.text = "Viewed"
            backgroundColor = .systemGray5
        } else {
            viewedLabel.text = "Unviewed"
            backgroundColor = .none
        }
    }
}

// MARK: Reloadable

extension NewsTableViewCell: Reloadable {
    func reloadData() {
        guard let viewModel = viewModel else { return }
        updateContent(viewModel: viewModel)
    }
}

// MARK: setupView

extension NewsTableViewCell {
    private func makeConstraints() {
        contentImageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview().inset(8)
            make.width.equalTo(96)
        }

        titleLabel.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(8)
            make.leading.equalTo(contentImageView.snp.trailing).inset(-16)
        }

        viewedLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.bottom.equalTo(contentImageView)
        }

        datePubLabel.snp.makeConstraints { make in
            make.trailing.equalTo(titleLabel)
            make.bottom.equalTo(contentImageView)
        }
    }

    private func setUpViews() {
        addSubview(contentImageView)
        addSubview(titleLabel)
        addSubview(datePubLabel)
        addSubview(viewedLabel)
    }
}
