//
//  HomeContentView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI
import AlertToast

struct HomeContentView: View {
    var headerHeight: Binding<CGFloat>
    @StateObject var viewModel: ViewModel

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack {
                    if viewModel.type == .movie {                        
                        MediaCarouselView(type: .popular)
                            .environmentObject(viewModel)
                    }

                    GridView()
                        .environmentObject(viewModel)
                }
                .padding(.vertical, headerHeight.wrappedValue)
            }
            .scrollIndicators(.hidden)
            .fullScreenCover(isPresented: $viewModel.showDetailMedia) {
                if let detailMediaToShow = viewModel.detailMediaToShow {
                    MediaDetailView(
                        viewModel: .init(
                            apiService: viewModel.apiService,
                            media: detailMediaToShow,
                            type: viewModel.type
                        )
                    )
                }
            }
            .toast(isPresenting: $viewModel.showToast, duration: 1) {
                if let toastInfo = viewModel.toastInfo {
                    AlertToast(
                        type: .systemImage(toastInfo.imageName, toastInfo.color),
                        title: toastInfo.text
                    )
                } else {
                    AlertToast(
                        type: .error(.white),
                        title: "An error occurred"
                    )
                }
            }
        }
    }
}
