//
//  NewsTableViewCell.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import Foundation
import UIKit

class NewsTableViewCell: UITableViewCell {

    let image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "img"))
        image.translatesAutoresizingMaskIntoConstraints = false

        image.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        return image
    }()

    let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    let dateCreate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    let viewedCheckbox: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "Sucsess"
        return label
    }()

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
        addSubview(descriptionLabel)
        addSubview(dateCreate)
        addSubview(viewedCheckbox)
    }

    private func configure() {
        //contentView.backgroundColor = .lightGray
        //contentView.layer.cornerRadius = 10
        contentView.alpha = 0.5
    }

}

//MARK: - setConstraints
extension NewsTableViewCell {
    private func makeConstraints() {

        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.topAnchor.constraint(equalTo: topAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
            image.widthAnchor.constraint(equalToConstant: 100)
        ])

        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            title.topAnchor.constraint(equalTo: topAnchor, constant: 8),
        ])

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: title.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: dateCreate.topAnchor, constant: -8),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])

        NSLayoutConstraint.activate([
            dateCreate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dateCreate.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])

        NSLayoutConstraint.activate([
            viewedCheckbox.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            viewedCheckbox.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}

