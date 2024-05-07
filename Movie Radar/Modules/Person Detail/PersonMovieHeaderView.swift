//
//  PersonMovieHeaderView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 7/5/24.
//

import SwiftUI

struct PersonMovieHeaderView: View {
    @EnvironmentObject var viewModel: PersonDetailView.ViewModel
    var proxy: GeometryProxy

    var body: some View {
        ZStack {
            AsyncImage(url: viewModel.person?.imageUrl) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                PlaceholderView(type: .person)
            }
            .frame(
                width: proxy.size.width,
                height: proxy.size.width * 1.33
            )
            .clipped()

            LinearGradient(
                stops: [
                    Gradient.Stop(color: .clear, location: 0.6),
                    Gradient.Stop(color: UIColor.systemBackground.color, location: 0.95)
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            VStack(spacing: 4) {
                Spacer()
                HStack {
                    Text(viewModel.person?.name ?? "")
                        .foregroundStyle(.white)
                        .lineLimit(3)
                        .font(.system(size: 30))
                        .shadow(radius: 1)
                    Spacer()
                }

                if let birthInfo = viewModel.birthInfo {
                    HStack {
                        Text(birthInfo)
                            .font(.system(size: 14))

                        Spacer()
                    }
                    .padding(.top, 2)
                }
            }
            .padding()
        }
    }
}
