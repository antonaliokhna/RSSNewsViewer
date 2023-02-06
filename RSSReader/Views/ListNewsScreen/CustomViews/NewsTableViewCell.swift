//
//  NewsTableViewCell.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import Foundation
import UIKit

private struct Constants {
    static let viewed: String = "Viewed"
    static let unviewed: String = "Unviewed"
    static let viewedBackroundColor: UIColor = .systemGray5

    struct Subview {
        static let cornerRadius: CGFloat = 16
        static let titleSize: CGFloat = 16
        static let subTitleSize: CGFloat = 14Ability to view all the details of the news, as well as the option to go to the article site.
        static let titleCountOfLines: Int = 3
        static let lineSpacing: CGFloat = 8
        static let lineCorderRadius: Int = 8
        static let bottomPadding: CGFloat = 8
        static let litleLineHeight: CGFloat = 13
        static let lastLineFill: Int = 100
    }

    struct Skeleton {
        static let bottomPadding: CGFloat = 0
        static let lineHeight: CGFloat = 15
        static let lineSpacing: CGFloat = 10
        static let lastLineFill: Int = 70
        static let lineCornerRadius: Int = 0
    }

    struct Constraints {
        static let contentPadding: CGFloat = 8
        static let imageWidth: CGFloat = 96
        static let titleLeadingPadding: CGFloat = -16
        static let defaultSubViewsWidth: CGFloat = 128
    }
}

final class NewsTableViewCell: UITableViewCell {
    static let identifier = "newsCell"

    private let contentImageView: UIImageView = {
        let image = UIImageView(image: nil)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = Constants.Subview.cornerRadius
        image.isSkeletonable = true

        return image
    }()

    private let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = Constants.Subview.titleCountOfLines
        title.font = .systemFont(
            ofSize: Constants.Subview.titleSize,
            weight: .bold
        )

        skeletonConfig(
            view: title,
            lineSpacing: Constants.Subview.lineSpacing,
            lineCornerRadius: Constants.Subview.lineCorderRadius
        )
        title.isSkeletonable = true

        return title
    }()

    private let datePubLabel: UILabel = {
        let date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.font = .systemFont(
            ofSize: Constants.Subview.subTitleSize,
            weight: .light
        )

        skeletonConfig(
            view: date,
            bottomPadding: Constants.Subview.bottomPadding,
            lineHeight: Constants.Subview.litleLineHeight,
            lastLineFill: Constants.Subview.lastLineFill,
            lineCornerRadius: Constants.Subview.lineCorderRadius
        )
        date.isSkeletonable = true

        return date
    }()

    private let viewedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(
            ofSize: Constants.Subview.subTitleSize,
            weight: .light
        )

        skeletonConfig(
            view: label,
            bottomPadding: Constants.Subview.bottomPadding,
            lineHeight: Constants.Subview.litleLineHeight,
            lineCornerRadius: Constants.Subview.lineCorderRadius
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
            viewedLabel.text = Constants.viewed
            backgroundColor = Constants.viewedBackroundColor
        } else {
            viewedLabel.text = Constants.unviewed
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
        bottomPadding: CGFloat = Constants.Skeleton.bottomPadding,
        lineHeight: CGFloat = Constants.Skeleton.lineHeight,
        lineSpacing: CGFloat = Constants.Skeleton.lineSpacing,
        lastLineFill: Int = Constants.Skeleton.lastLineFill,
        lineCornerRadius: Int = Constants.Skeleton.lineCornerRadius
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
            make
                .verticalEdges.leading
                .equalToSuperview()
                .inset(Constants.Constraints.contentPadding)

            make.width.equalTo(Constants.Constraints.imageWidth)
        }

        titleLabel.snp.makeConstraints { make in
            make
                .trailing.top
                .equalToSuperview()
                .inset(Constants.Constraints.contentPadding)

            make
                .leading
                .equalTo(contentImageView.snp.trailing)
                .inset(Constants.Constraints.titleLeadingPadding)
        }

        viewedLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.bottom.equalTo(contentImageView)
            make.width.equalTo(Constants.Constraints.defaultSubViewsWidth)
        }

        datePubLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.bottom.equalTo(contentImageView)
            make.width.equalTo(Constants.Constraints.defaultSubViewsWidth)
        }
    }
}
