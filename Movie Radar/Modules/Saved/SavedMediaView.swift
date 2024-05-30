//
//  SavedMediaView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI
import SwiftData
import AlertToast

struct SavedMediaView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @StateObject var viewModel: ViewModel
    @State var headerHeight: CGFloat = 0

    var body: some View {
        ZStack {
            TabView(selection: $viewModel.selectedTab) {
                ForEach(Array(SavedType.allCases.enumerated()), id: \.1.self) { (index, savedType) in
                    SavedMediaGridView(
                        viewModel: viewModel,
                        type: savedType,
                        headerHeight: $headerHeight
                    )
                    .tag(index)
                }
            }
            .ignoresSafeArea()
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            VStack {
                HStack(spacing: 0) {
                    TabViewHeader(
                        selectedTab: $viewModel.selectedTab,
                        headerType: .saved, 
                        titles: SavedType.allCases.map { $0.title }
                    )
                    
                    HStack(spacing: 12) {
                        Button {
                            // TO DO
                        } label: {
                            Image(systemName: "books.vertical.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                        }
                        
                        Button {
                            viewModel.showFilters.toggle()
                        } label: {
                            Image(systemName: viewModel.filtersApplied ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                        }
                    }
                    .foregroundStyle(appGradient.value)
                    .opacity(0.75)
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(.ultraThinMaterial)
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear {
                                headerHeight = proxy.size.height
                            }
                    }
                )

                Spacer()
            }
        }
        .fullScreenCover(isPresented: $viewModel.showDetailMedia) {
            if let detailMediaToShow = viewModel.detailMediaToShow {
                MediaDetailView(
                    viewModel: .init(
                        apiService: viewModel.apiService,
                        media: detailMediaToShow.detail,
                        type: detailMediaToShow.type
                    )
                )
            }
        }
        .sheet(isPresented: $viewModel.showFilters) {
            FiltersView(
                viewModel: .init(
                    gridSearchText: $viewModel.searchText,
                    filtersApplied: $viewModel.filtersApplied,
                    startDate: $viewModel.startDate,
                    endDate: $viewModel.endDate,
                    selectedMediaType: $viewModel.selectedMediaType
                )
            )
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
