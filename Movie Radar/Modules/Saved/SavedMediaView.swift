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
    @State var headerHeight: CGFloat = 0
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
                        userList: userList,
                        headerHeight: $headerHeight
                    )
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea(edges: .bottom)

            VStack {
                HStack(spacing: 12) {
                    Menu {
                        ForEach(Array(userLists.enumerated()), id: \.1.self) { index, list in
                            Button(action: {
                                viewModel.selectedTab = index
                            }, label: {
                                HStack {
                                    Label(
                                        list.title ?? "",
                                        systemImage: list.imageName ?? ""
                                    )
                                }
                            })
                        }
                    } label: {
                        let list = userLists.enumerated().first { index, list in
                            index == viewModel.selectedTab
                        }?.element
                        HStack {
                            Image(systemName: list?.imageName ?? "")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(list?.colorInfo?.color ?? .white)
                                .frame(width: 20, height: 20)
                            Text(list?.title ?? "")
                                .font(.system(size: 25, weight: .light))
                                .lineLimit(1)
                            Image(systemName: "chevron.down")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 10)
                            Spacer()
                        }
                        .frame(height: 35)
                    }
                    
                    HStack(spacing: 12) {
                        Button {
                            withAnimation(.spring) {
                                viewModel.showUserLists.toggle()
                            }
                        } label: {
                            Text("My lists")
                                .font(.system(size: 12, weight: .bold))
                                .frame(height: 25)
                                .padding(.horizontal, 8)
                                .clipShape(Capsule())
                                .background(
                                    Capsule()
                                        .stroke(
                                            appGradient.value,
                                            lineWidth: 2
                                        )
                                )
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
                .disabled(viewModel.showUserLists)
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
        .sensoryFeedback(.success, trigger: viewModel.selectedTab)
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
        .toast(
            show: $viewModel.showToast,
            toastInfo: viewModel.toastInfo
        )
    }
}
