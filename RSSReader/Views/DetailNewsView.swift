//
//  DetailNewsView.swift
//  RSSReader
//
//  Created by Anton Aliokhna on 2/3/23.
//

import SwiftUI

struct DetailNewsView: View {
    var body: some View {
        ScrollView {
            GeometryReader { geomerty in

                //TODO: Fix Invalid frame dimension (negative or non-finite).
                Image("no-image")

                    .scaledToFit()
                    .offset(y: -geomerty.frame(in: .global).minY)
                    .frame(
                        width: UIScreen.main.bounds.width,
                        height: geomerty.frame(in: .global).minY < 0 ?
                        geomerty.frame(in: .global).minY + 480 : 480)
            }
            .frame(height: 480)

            VStack(alignment: .leading, spacing: 16) {
                Text("Header")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                Text("Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc c Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc c Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc c Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc c Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc c Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc Desc ")
                    .font(.title3)
                    .multilineTextAlignment(.leading)
            }
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(20)
            .offset(y: -35)
        }
        .ignoresSafeArea()
        .toolbarBackground(.hidden, for: .navigationBar)
    }
}

struct DetailNewsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailNewsView()
    }
}
