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
            HStack {
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                
                if let voteAverage = viewModel.media.totalVoteAverage {
                    Text(String(format: "%.1f / 10", voteAverage))
                } else {
                    Text("- / 10")
                }
                
                Text(String(format: "(%d votes)", viewModel.media.voteCount ?? 0))
                    .opacity(0.6)
                Spacer()
            }
            .font(.system(size: 14))
            .foregroundStyle(.yellow)
            
            HStack(spacing: 25) {
                let budget = viewModel.media.budget ?? 0
                infoItem(
                    title: "Budget",
                    textToDisplay: budget > 0 ? "\(budget)" : nil
                )
                
                let revenue = viewModel.media.revenue ?? 0
                infoItem(
                    title: "Revenue",
                    textToDisplay: revenue > 0 ? "\(revenue)" : nil
                )
                
                infoItem(
                    title: "Release",
                    textToDisplay: viewModel.media.date
                )
                
                Spacer()
            }
            .padding(.top)

            Text(viewModel.media.overview ?? "")
                .multilineTextAlignment(.leading)
                .font(.system(size: 14))
        }
        .padding(.bottom)
    }
    
    @ViewBuilder
    func infoItem(
        title: String,
        textToDisplay: String?
    ) -> some View {
        if let textToDisplay {
            VStack {
                HStack {
                    Text(title)
                        .font(.system(size: 12, weight: .bold))
                    Spacer()
                }
                HStack {
                    Text(textToDisplay)
                        .font(.system(size: 14, weight: .light))
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    MediaDescriptionView()
}
