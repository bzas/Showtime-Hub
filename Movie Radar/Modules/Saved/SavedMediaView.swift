//
//  SavedMediaView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI
import SwiftData

struct SavedMediaView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @StateObject var viewModel: ViewModel
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\UserList.index)
    ]) var userLists: [UserList]
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            ForEach(Array(userLists.enumerated()), id: \.1.self) { (index, userList) in
                SavedMediaGridView(
                    viewModel: viewModel,
                    userList: userList
                )
                .environmentObject(viewModel)
                .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea(edges: .bottom)
        .sensoryFeedback(.success, trigger: viewModel.selectedTab)
        .background(
            ZStack {
                if viewModel.selectedListIndex < userLists.count {
                    let imagePath = userLists[viewModel.selectedListIndex].backgroundPath ?? ListBackground.abstract.imagePath(index: 0)
                    Image(imagePath)
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .transition(.blurReplace.animation(.default))

                    LinearGradient(
                        colors: [.clear, .black],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }

            }.ignoresSafeArea(edges: .top)
        )
        .opacity(viewModel.showUserLists ? 0.8 : 1)
        .blur(radius: viewModel.showUserLists ? 10 : 0)
        .overlay {
            if viewModel.showUserLists {
                UserListsView(
                    viewModel: .init(
                        showDetail: $viewModel.showUserLists,
                        selectedListIndex: $viewModel.selectedTab,
                        modelContext: modelContext
                    )
                )
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
        .sheet(isPresented: $viewModel.showBackgroundEditionView) {
            EditBackgroundView(userList: $viewModel.backgroundEditionList)
        }
        .toast(
            show: $viewModel.showToast,
            toastInfo: viewModel.toastInfo
        )
    }
}
