//
//  SearchView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 21/6/24.
//

import SwiftUI

struct SearchView: View {
    @AppStorage(LocalStorage.appGradientKey) var appGradient: AppGradient = .white
    @StateObject var viewModel: ViewModel
    @FocusState var isFocused: Bool
    
    let grayGradient = LinearGradient(
        colors: [UIColor.systemGray5.color],
        startPoint: .top,
        endPoint: .bottom
    )
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                TextField(
                    "",
                    text: $viewModel.searchText,
                    prompt: Text("Movies, series, actors...")
                )
                .focused($isFocused)
                .submitLabel(.search)
                .autocorrectionDisabled()
                .padding(8)
                .padding(.horizontal, 4)
                .background(.ultraThinMaterial)
                .clipShape(Capsule())
                .onSubmit {
                    viewModel.search()
                }
                .overlay {
                    if !viewModel.searchText.isEmpty {
                        HStack {
                            Spacer()
                            Button {
                                viewModel.resetSearch()
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .frame(width: 15, height: 15)
                                    .padding()
                                    .opacity(0.5)
                            }
                        }
                    }
                }
                
                Button {
                    isFocused = false
                    withAnimation {
                        viewModel.isSearching = false
                    }
                } label: {
                    Text("Cancel")
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    HStack {
                        Button {
                            withAnimation {
                                viewModel.isShowingMediaResults = true
                            }
                        } label: {
                            Text("Movies & Series")
                                .font(.system(size: 14, weight: .light))
                                .padding(.horizontal)
                                .frame(height: 30)
                                .foregroundStyle(viewModel.isShowingMediaResults ? .black : .white)
                                .background(viewModel.isShowingMediaResults ? appGradient.value : grayGradient)
                                .clipShape(Capsule())
                        }
                        
                        Button {
                            withAnimation {
                                viewModel.isShowingMediaResults = false
                            }
                        } label: {
                            Text("People")
                                .font(.system(size: 14, weight: .light))
                                .padding(.horizontal)
                                .frame(height: 30)
                                .foregroundStyle(!viewModel.isShowingMediaResults ? .black : .white)
                                .background(!viewModel.isShowingMediaResults ? appGradient.value : grayGradient)
                                .clipShape(Capsule())
                        }
                        Spacer()
                    }
                    
                    if viewModel.isShowingMediaResults {
                        if viewModel.searchMediaResults.isEmpty,
                           !viewModel.searchText.isEmpty,
                           !isFocused {
                            if viewModel.isLoading {
                                ProgressView()
                                    .frame(height: 100)
                            } else {
                                Text("No results found")
                                    .frame(height: 100)
                            }
                        } else {
                            ForEach(viewModel.searchMediaResults, id: \.self) { searchResult in
                                MediaCellView(
                                    media: searchResult.media,
                                    type: searchResult.type
                                )
                                .onTapGesture {
                                    viewModel.detailResultToShow = searchResult
                                }
                                .contextMenu {
                                    MediaContextMenu(
                                        apiService: viewModel.apiService,
                                        media: searchResult.media,
                                        mediaType: searchResult.type,
                                        toastInfo: $viewModel.toastInfo
                                    )
                                }
                            }
                        }
                    } else {
                        if viewModel.searchPeopleResults.results.isEmpty,
                           !viewModel.searchText.isEmpty,
                           !isFocused {
                            if viewModel.isLoading {
                                ProgressView()
                                    .frame(height: 100)
                            } else {
                                Text("No results found")
                                    .frame(height: 100)
                            }
                        } else {
                            ForEach(viewModel.searchPeopleResults.results, id: \.self) { searchPerson in
                                PersonCellView(person: searchPerson)
                                .onTapGesture {
                                    viewModel.detailPersonIdToShow = searchPerson.id
                                }
                            }
                        }
                    }
                }
                .padding()
                .padding(.bottom, 48)
            }
            Spacer()
        }
        .fullScreenCover(isPresented: $viewModel.showDetailMedia) {
            if let detailResultToShow = viewModel.detailResultToShow {
                MediaDetailView(
                    viewModel: .init(
                        apiService: viewModel.apiService,
                        media: detailResultToShow.media,
                        type: detailResultToShow.type
                    )
                )
            }
        }
        .sheet(isPresented: $viewModel.showDetailPerson) {
            if let detailPersonIdToShow = viewModel.detailPersonIdToShow {
                PersonDetailView(
                    viewModel: .init(
                        apiService: viewModel.apiService,
                        personId: detailPersonIdToShow
                    )
                )
            }
        }
        .toast(
            show: $viewModel.showToast,
            toastInfo: viewModel.toastInfo
        )
        .onAppear {
            isFocused = true
        }
    }
}
