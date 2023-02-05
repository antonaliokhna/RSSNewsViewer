//
//  DetailNewsView.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import SwiftUI

private struct Constants {
    static let contentCornerRadius: CGFloat = 16
    static let contentOffset: CGFloat = -24
    static let imageHeight: CGFloat
        = UIScreen.main.bounds.height / 1.8
}

private struct ContentConstants {
    static let rectangleWidht: CGFloat = 48
    static let rectangleHeight: CGFloat = 4
    static let rectangleCornerRadius: CGFloat = 24
    static let defaultSpacing: CGFloat = 8
}

struct DetailNewsView: View {
    @ObservedObject var viewModel: NewsViewModel

    var body: some View {
        ScrollView(showsIndicators: false) {
            paralaxImage

            VStack {
                contentView
            }
            .background(.bar)
            .cornerRadius(Constants.contentCornerRadius)
            .offset(y: Constants.contentOffset)
        }
        .ignoresSafeArea()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(viewModel.category)
        .onAppear {
            viewModel.setViewed(status: true)
        }
    }

    private var paralaxImage: some View {
        GeometryReader { geomerty in
            let frame = geomerty.frame(in: .global)

            Image(uiImage: viewModel.image)
                .resizable()
                .scaledToFill()
                .offset(y: -frame.minY)
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: frame.maxY
                )
        }
        .frame(height: Constants.imageHeight)
    }

    private var contentView: some View {
        VStack {
            VStack(alignment: .leading) {
                Rectangle()
                    .frame(
                        width: ContentConstants.rectangleWidht,
                        height: ContentConstants.rectangleHeight
                    )
                    .cornerRadius(ContentConstants.rectangleCornerRadius)
                    .frame(maxWidth: .infinity)

                Text(viewModel.title)
                    .font(.title)
                    .fontWeight(.bold)
            }

            Divider()
            HStack {
                VStack(alignment: .leading) {
                    Text("Autor:")
                        .font(.subheadline)
                        .fontWeight(.light)

                    Text(viewModel.author)
                        .font(.headline)
                        .bold()
                }

                Spacer()
                VStack(alignment: .leading) {
                    Text("Publication:")
                        .font(.subheadline)
                        .fontWeight(.light)

                    Text(viewModel.pubDate.description)
                        .font(.headline)
                        .bold()
                }
            }

            Divider()
            VStack(
                alignment: .leading,
                spacing: ContentConstants.defaultSpacing
            ) {
                Text("Description:")
                    .fontWeight(.light)

                Text(viewModel.description)
                    .font(.headline)
                    .fontWeight(.medium)
            }

            Divider()

            Link("Link to article", destination: viewModel.link)
        }
        .padding()
    }
}

struct DetailNewsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailNewsView(
            viewModel: NewsViewModel(
                networkService: NetworkDataService(),
                localService: LocalDataService(),
                newsModel: NewsModel(
                    author: "Test author",
                    title: "Test empty title",
                    link: URL(string: "https")!,
                    description: "Description here",
                    pubDate: Date(),
                    enclosure: .init(url: URL(string: "https")!),
                    category: "Test category",
                    viewed: false,
                    imageData: nil
                )
            )
        )
    }
}
