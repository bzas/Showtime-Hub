//
//  MediaTopMenuView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 9/6/24.
//

import SwiftUI

struct MediaTopMenuView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: MediaDetailView.ViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(.black.opacity(0.5))
                        .padding(10)
                        .background(.white.opacity(0.75))
                        .clipShape(Circle())
                        .shadow(
                            color: .black.opacity(0.75),
                            radius: 2
                        )
                }
                
                Spacer()
                
                SaveMediaStackView(
                    media: viewModel.media,
                    mediaType: viewModel.type,
                    toastInfo: $viewModel.toastInfo
                )
                .disabled(viewModel.showToast)
            }
            .disabled(viewModel.showDetailImage || viewModel.showDetailSeason || viewModel.showDetailReview || viewModel.isHeaderHidden)
            .opacity((viewModel.showDetailImage || viewModel.showDetailSeason || viewModel.showDetailReview) ? 0 : 1)
            .scaleEffect(viewModel.isHeaderHidden ? 0 : 1)

            Spacer()
        }

        .padding(.top, 6)
        .padding(.horizontal)
    }
}
