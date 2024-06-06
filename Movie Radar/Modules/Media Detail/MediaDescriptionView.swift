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
                HStack(spacing: 12) {
                    infoItem(
                        title: "Budget",
                        textToDisplay: budget > 0 ? "\(budget)$" : nil
                    )
                                        
                    infoItem(
                        title: "Revenue",
                        textToDisplay: revenue > 0 ? "\(revenue)$" : nil
                    )
                                        
                    infoItem(
                        title: "Release",
                        textToDisplay: viewModel.media.dateString
                    )
                }
                .padding(.top)
            } else {
                HStack {
                    HStack(spacing: 0) {
                        Text("Release")
                            .font(.system(size: 12, weight: .bold))
                            .padding(6)
                            .padding(.horizontal, 6)
                            .frame(maxHeight: .infinity)
                            .background(UIColor.systemGray6.color)
                        
                        Text(viewModel.media.dateString ?? "No information")
                            .font(.system(size: 14, weight: .light))
                            .padding(6)
                            .padding(.horizontal, 6)
                            .frame(maxHeight: .infinity)
                            .background(UIColor.systemGray4.color)
                    }
                    .frame(height: 35)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
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
            VStack(spacing: 0) {
                Text(title)
                    .font(.system(size: 12, weight: .semibold))
                    .padding(8)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(UIColor.systemGray6.color)
                
                Text(textToDisplay)
                    .font(.system(size: 14, weight: .light))
                    .padding(6)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(UIColor.systemGray4.color)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    MediaDescriptionView()
}
