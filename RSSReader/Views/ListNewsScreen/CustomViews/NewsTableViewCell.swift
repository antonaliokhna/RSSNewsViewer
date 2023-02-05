//
//  NewsTableViewCell.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import Foundation
import UIKit

final class NewsTableViewCell: UITableViewCell {
    static let identifier = "newsCell"

    private let contentImageView: UIImageView = {
        let image = UIImageView(image: nil)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 16
        image.isSkeletonable = true

        return image
    }()

    private let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = .systemFont(ofSize: 16, weight: .bold)
        title.numberOfLines = 3

        skeletonConfig(view: title, lineSpacing: 8, lineCornerRadius: 8)
        title.isSkeletonable = true

        return title
    }()

    private let datePubLabel: UILabel = {
        let date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.font = .systemFont(ofSize: 14, weight: .light)

        skeletonConfig(
            view: date,
            bottomPadding: 8,
            lineHeight: 13,
            lastLineFill: 100,
            lineCornerRadius: 8
        )
        date.isSkeletonable = true

        return date
    }()

    private let viewedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .light)

        skeletonConfig(
            view: label,
            bottomPadding: 8,
            lineHeight: 13,
            lineCornerRadius: 8
        )
        label.isSkeletonable = true

        return label
    }()

    private weak var viewModel: CellViewModelType? {
        didSet {
            viewModel?.reloableDelegate = self
            reloadData()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUpViews()
        makeConstraints()
        configurate()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setViewModel(viewModel: CellViewModelType) {
        self.viewModel = viewModel
    }
}

// MARK: private updated view functions

extension NewsTableViewCell {
    private func updateContent(viewModel: CellViewModelType) {
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

// MARK: Skeleton configuration

extension NewsTableViewCell {
    private static func skeletonConfig(
        view: UILabel,
        bottomPadding: CGFloat = 0,
        lineHeight: CGFloat = 15,
        lineSpacing: CGFloat = 10,
        lastLineFill: Int = 70,
        lineCornerRadius: Int = 0
    ) {
        view.isSkeletonable = true
        view.skeletonPaddingInsets.bottom = bottomPadding
        view.skeletonTextLineHeight = .fixed(lineHeight)
        view.lastLineFillPercent = lastLineFill
        view.linesCornerRadius = lineCornerRadius
    }
}

// MARK: setupView

extension NewsTableViewCell {
    private func configurate() {
        isSkeletonable = true
    }

    private func setUpViews() {
        contentView.addSubview(datePubLabel)
        contentView.addSubview(viewedLabel)
        contentView.addSubview(contentImageView)
        contentView.addSubview(titleLabel)
    }

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
            make.width.equalTo(128)
        }

        datePubLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.bottom.equalTo(contentImageView)
            make.width.equalTo(128)
        }
    }
}
