//
//  PersonDetailView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 5/5/24.
//

import SwiftUI

struct PersonDetailView: View {
    @StateObject var viewModel: ViewModel

    var body: some View {
        if viewModel.detailLoaded,
           viewModel.person == nil {
            Text("No profile data")
                .presentationDetents([.medium])
        } else {
            GeometryReader { _ in
                VStack(spacing: 8) {
                    HStack {
                        AsyncImage(url: viewModel.person?.imageUrl) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipped()
                        } placeholder: {
                            PlaceholderView(type: .person)
                        }
                        .frame(
                            width: 150,
                            height: 200
                        )

                        VStack {
                            HStack {
                                Text(viewModel.person?.name ?? "")
                                    .foregroundStyle(LinearGradient.appGradient)
                                    .lineLimit(3)
                                    .font(.system(size: 16, weight: .light))
                                Spacer()
                            }

                            if let birthInfo = viewModel.birthInfo {
                                HStack {
                                    Text(birthInfo)
                                        .font(.system(size: 14, weight: .light))

                                    Spacer()
                                }
                            }

                            ScrollView {
                                Text(viewModel.person?.biography ?? "")
                                    .font(.system(size: 12, weight: .light))
                            }
                            .scrollIndicators(.hidden)

                            Spacer()
                        }
                        .frame(height: 200)
                    }

                    Spacer()
                }
                .padding()
            }
            .presentationDetents([.medium])
        }
    }
}
