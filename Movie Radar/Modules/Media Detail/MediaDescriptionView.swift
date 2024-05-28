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
                if let voteAverage = viewModel.media.totalVoteAverage {
                    HStack(spacing: 0) {
                        Text(String(format: "%.1f", voteAverage))
                            .font(.system(size: 25, weight: .semibold))
                        Text(" / 10")
                            .font(.system(size: 14))
                    }
                } else {
                    Text("- / 10")
                        .font(.system(size: 14))
                }
                
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                
                Text(String(format: "(%d votes)", viewModel.media.voteCount ?? 0))
                    .opacity(0.6)
                    .font(.system(size: 14))
                Spacer()
            }
            .foregroundStyle(.yellow)
            
            let budget = viewModel.media.budget ?? 0
            let revenue = viewModel.media.revenue ?? 0
            if budget > 0 || revenue > 0 {
                HStack(spacing: 8) {
                    infoItem(
                        title: "Budget",
                        textToDisplay: budget > 0 ? "\(budget)" : nil
                    )
                    
                    Spacer()
                    
                    infoItem(
                        title: "Revenue",
                        textToDisplay: revenue > 0 ? "\(revenue)" : nil
                    )
                    
                    Spacer()
                    
                    infoItem(
                        title: "Release",
                        textToDisplay: viewModel.media.dateString
                    )
                }
                .padding(.top)
                .padding(.horizontal)
            } else {
                HStack(spacing: 12) {
                    Text("Release")
                        .font(.system(size: 12, weight: .bold))
                    Text(viewModel.media.dateString ?? "No information")
                        .font(.system(size: 14, weight: .light))
                    Spacer()
                }
            }

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
                Text(title)
                    .font(.system(size: 12, weight: .bold))
                
                Text(textToDisplay)
                    .font(.system(size: 14, weight: .light))
            }
        }
    }
}

#Preview {
    MediaDescriptionView()
}
