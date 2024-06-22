//
//  SearchView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 21/6/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: ViewModel
    @FocusState var isFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                TextField(
                    "",
                    text: $viewModel.searchText,
                    prompt: Text("Search...")
                )
                .focused($isFocused)
                .submitLabel(.search)
                .autocorrectionDisabled()
                .padding(8)
                .padding(.horizontal, 4)
                .background(.ultraThinMaterial)
                .clipShape(Capsule())
                .onSubmit {
                    Task {
                        await viewModel.searchMedia()
                    }
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

            if viewModel.searchResults.isEmpty,
               !viewModel.searchText.isEmpty,
               !isFocused {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxHeight: .infinity)
                } else {
                    Text("No results found")
                        .frame(maxHeight: .infinity)
                }
            } else {
               ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.searchResults, id: \.self) { searchResult in
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
                    .padding()
                    .padding(.bottom, 48)
                }
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
        .toast(
            show: $viewModel.showToast,
            toastInfo: viewModel.toastInfo
        )
        .onAppear {
            isFocused = true
        }
    }
}
