//
//  MediaDescriptionView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 2/5/24.
//

import SwiftUI

struct MediaDescriptionView: View {
    @EnvironmentObject var viewModel: MediaDetailView.ViewModel

    var body: some View {
        VStack(spacing: 12) {
            if let voteAverage = viewModel.media.voteAverage {
                HStack {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                    Text(String(format: "%.1f / 10", voteAverage))
                        .font(.system(size: 15))
                    Spacer()
                }
                .foregroundStyle(.yellow)
            }

            if let budget = viewModel.media.budget,
               budget > 0 {
                HStack {
                    Text("Budget")
                        .bold()
                    Text("\(budget)$")
                        .fontWeight(.light)
                    Spacer()
                }
                .font(.system(size: 14))
            }

            if let revenue = viewModel.media.revenue,
               revenue > 0 {
                HStack {
                    Text("Revenue")
                        .bold()
                    Text("\(revenue)$")
                        .fontWeight(.light)
                    Spacer()
                }
                .font(.system(size: 14))
            }

            Text(viewModel.media.overview ?? "")
                .multilineTextAlignment(.leading)
                .font(.system(size: 14))
        }
        .padding(.bottom)
    }
}

#Preview {
    MediaDescriptionView()
}
