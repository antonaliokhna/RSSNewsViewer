//
//  DetailNewsView.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import SwiftUI

struct DetailNewsView: View {
    @ObservedObject var viewModel: NewsViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            paralaxImage

            VStack {
                contentView
            }
            .background(.bar)
            .cornerRadius(16)
            .offset(y: -45)
        }
        .ignoresSafeArea()
        .navigationTitle(viewModel.category)
        .navigationBarTitleDisplayMode(.inline)
        .background(BackroundGradientView())
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
        .frame(height: UIScreen.main.bounds.height/2)
    }

    private var contentView: some View {
        VStack {
            VStack(alignment: .leading) {
                Rectangle()
                    .frame(width: 48, height: 4)
                    .cornerRadius(24)
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

                    Text(viewModel.pubDate)
                        .font(.headline)
                        .bold()
                }
            }

            Divider()

            VStack(alignment: .leading, spacing: 8) {
                Text("Description:")
                    .fontWeight(.light)

                Text(viewModel.description)
                    .font(.headline)
                    .fontWeight(.medium)
            }

            Divider()

            if let link = viewModel.link {
                Link("Link to article", destination: link)
            }
        }
        .padding()
    }
}


//struct DetailNewsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewsViewController()
//    }
//}

enum ColorTheme {
    static let dark = [
        Color(red: 0/255, green: 130/255, blue: 160/255, opacity: 0.5),
        Color(red: 140/255, green: 0/255, blue: 160/255, opacity: 0.5),
    ]
    static let light = [
        Color(red: 0/255, green: 230/255, blue: 255/255, opacity: 0.6),
        Color(red: 255/255, green: 130/255, blue: 200/255, opacity: 0.6),
    ]
}

struct BackroundGradientView: View {
    @Environment(\.colorScheme) private var colorScheme: ColorScheme

    var body: some View {
        let cutomColorScheme =
            colorScheme == .dark
                ? ColorTheme.dark
                : ColorTheme.light

        let gradient = Gradient(colors: cutomColorScheme)
        let linearGradient = LinearGradient(
            gradient: gradient,
            startPoint: .top,
            endPoint: .bottom
        )

        let background = Rectangle()
            .fill(linearGradient)
            .edgesIgnoringSafeArea(.all)

        return background
    }
}

struct BackroundGradientView_Previews: PreviewProvider {
    static var previews: some View {
        BackroundGradientView()
    }
}
