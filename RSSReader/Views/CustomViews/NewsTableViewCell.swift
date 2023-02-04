//
//  NewsTableViewCell.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import Foundation
import UIKit

final class NewsTableViewCell: UITableViewCell {

    private let image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "img"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 16

        return image
    }()

    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 3

        return label
    }()

    private let dateCreate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .light)

        return label
    }()

    private let viewedCheckbox: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .light)

        label.text = "No"
        return label
    }()

    //private let abobus: Image

    var cellViewModel: NewsViewModel? {
        didSet {
            //print("das")
            Task {
               try? await cellViewModel?.loadImage()
            }
            guard let cellViewModel = cellViewModel else { return }
            cellViewModel.reloable = self
            setValueBy(viewModel: cellViewModel)
        }
    }

    func setValueBy(viewModel: NewsViewModel) {
        image.image = viewModel.image
        title.text = viewModel.title
        dateCreate.text = viewModel.pubDate

        if viewModel.viewed {
            viewedCheckbox.text = "Viewed!"
            backgroundColor = .systemGray5
        } else {
            backgroundColor = .none
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUpViews()
        makeConstraints()
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViews() {
        addSubview(image)
        addSubview(title)
        addSubview(dateCreate)
        addSubview(viewedCheckbox)
    }

    private func configure() {
        //contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 10

    }

}

//MARK: Reloadable
extension NewsTableViewCell: Reloadable {
    func reloadData() {
        guard let viewModel = cellViewModel else { return }
        setValueBy(viewModel: viewModel)
    }
}

//MARK: - setConstraints
extension NewsTableViewCell {
    private func makeConstraints() {

        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            image.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            image.widthAnchor.constraint(equalToConstant: 96)
        ])

        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            title.topAnchor.constraint(equalTo: topAnchor, constant: 8),
        ])

        NSLayoutConstraint.activate([
            viewedCheckbox.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            viewedCheckbox.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])

        NSLayoutConstraint.activate([
            dateCreate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dateCreate.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}

