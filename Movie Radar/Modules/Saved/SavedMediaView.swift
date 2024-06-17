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
        ZStack {
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

            VStack {
                HStack(spacing: 12) {
                    Spacer()
                    Button {
                        withAnimation(.spring) {
                            viewModel.showUserLists.toggle()
                        }
                    } label: {
                        Text("My lists")
                            .font(.system(size: 16))
                            .frame(height: 40)
                            .padding(.horizontal)
                            .clipShape(Capsule())
                            .background(
                                Capsule()
                                    .fill(.ultraThinMaterial)
                            )
                    }
                    
                    Button {
                        viewModel.showFilters.toggle()
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease")
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                    }
                }
                .foregroundStyle(appGradient.value)
                .disabled(viewModel.showUserLists)
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear {
                                viewModel.headerHeight = proxy.size.height
                            }
                    }
                )
                Spacer()
            }
        }
        .sensoryFeedback(.success, trigger: viewModel.selectedTab)
        .background(
            ZStack {
                Image(ListBackground.city.imagePath(index: 10))
                    .resizable()
                    .scaledToFill()
                    .clipped()
                
                LinearGradient(
                    stops: [
                        .init(color: .clear, location: 0.3),
                        .init(color: .black, location: 1)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }.ignoresSafeArea(edges: .top)
        )
        .opacity((viewModel.showUserLists || viewModel.showDetailList) ? 0.8 : 1)
        .blur(radius: (viewModel.showUserLists || viewModel.showDetailList) ? 10 : 0)
        .overlay {
            if viewModel.showUserLists {
                UserListsView(
                    viewModel: .init(
                        showDetail: $viewModel.showUserLists,
                        selectedListIndex: $viewModel.selectedTab,
                        modelContext: modelContext
                    )
                )
            } else if viewModel.showDetailList {
                
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
        .toast(
            show: $viewModel.showToast,
            toastInfo: viewModel.toastInfo
        )
    }
}
