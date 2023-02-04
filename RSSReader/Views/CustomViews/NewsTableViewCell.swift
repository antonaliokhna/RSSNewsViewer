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

    weak var viewModel: NewsViewModel?


    var cellViewModel: NewsViewModel? {
        didSet {
            //print("das")
//            Task {
//               try? await cellViewModel?.loadImage()
//            }
            //guard let cellViewModel = cellViewModel else { return }
            //cellViewModel.reloable = self
            //setViewModel(viewModel: cellViewModel)
        }
    }

    func setViewModel(viewModel: NewsViewModel) {
        viewModel.reloable = self
        self.viewModel = viewModel
        loadImageFromViewModel()

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

    private func loadImageFromViewModel() {
        Task {
           await viewModel?.loadImage()
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

    private func setUpViews() {
        addSubview(image)
        addSubview(title)
        addSubview(dateCreate)
        addSubview(viewedCheckbox)
    }
}

//MARK: Reloadable
extension NewsTableViewCell: Reloadable {
    func reloadData() {
        guard let viewModel = viewModel else { return }
        setViewModel(viewModel: viewModel)
    }
}

//MARK: makeConstraints
extension NewsTableViewCell {
    private func makeConstraints() {
        image.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview().inset(8)
            make.width.equalTo(96)
        }

        title.snp.makeConstraints { make in
            make.trailing.top.equalToSuperview().inset(8)
            make.leading.equalTo(image.snp.trailing).inset(-16)
        }

        viewedCheckbox.snp.makeConstraints { make in
            make.leading.equalTo(title)
            make.bottom.equalTo(image)
        }

        dateCreate.snp.makeConstraints { make in
            make.trailing.equalTo(title)
            make.bottom.equalTo(image)
        }
    }
}

