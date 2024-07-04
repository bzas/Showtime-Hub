//
//  SavedMediaGridView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 18/5/24.
//

import SwiftUI
import SwiftData

struct SavedMediaGridView: View {
    @ObservedObject var viewModel: SavedMediaView.ViewModel
    @Query var mediaItems: [SavedMedia]
    @State var userList: UserList
    @State var isEditingItems = false
    
    init(
        viewModel: SavedMediaView.ViewModel,
        userList: UserList
    ) {
        self.viewModel = viewModel
        self.userList = userList
        _mediaItems = Query(
            filter: viewModel.filtersPredicate(userList: userList),
            sort: \SavedMedia.detail.name
        )
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                SavedMediaListHeaderView(
                    userList: userList,
                    mediaItems: mediaItems, 
                    isEditingItems: $isEditingItems
                )
                .environmentObject(viewModel)
                
                if mediaItems.isEmpty {
                    VStack {
                        Spacer()
                        Text("No items saved yet")
                            .shadow(radius: 2)
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                        Spacer()
                    }
                } else {
                    HStack {
                        Spacer()
                        Button {
                            withAnimation {
                                isEditingItems = false
                            }
                        } label: {
                            Text("Done")
                                .font(.system(size: 14))
                        }
                    }
                    .padding(.horizontal, 24)
                    .disabled(!isEditingItems)
                    .opacity(isEditingItems ? 1 : 0)
                    
                    LazyVStack(spacing: 16) {
                        ForEach(mediaItems, id: \.self) { media in
                            HStack(spacing: 16) {
                                if isEditingItems {
                                    Button {
                                        viewModel.removeFromList(
                                            media: media,
                                            userList: userList,
                                            mediaItems: mediaItems
                                        )
                                    } label: {
                                        Image(systemName: "trash")
                                            .scaledToFit()
                                            .frame(width: 30, height: 30)
                                            .background(.red.opacity(0.75))
                                            .clipShape(Circle())
                                    }
                                }
                                
                                MediaCellView(
                                    media: media.detail,
                                    type: media.type
                                )
                                .onTapGesture {
                                    viewModel.detailMediaToShow = media
                                }
                                .contextMenu {
                                    DeleteItemMenu(
                                        media: media,
                                        userList: userList
                                    )
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                }
            }
        }
        .scrollIndicators(.hidden)
        .alert(
            String(
                format: NSLocalizedString("Are you sure you want to delete \"%@\" list?", comment: ""),
                viewModel.listToDelete?.title ?? ""
            ),
            isPresented: $viewModel.showDeleteListAlert
        ) {
            Button("Cancel", role: .cancel) {
                viewModel.listToDelete = nil
            }
            Button("Delete", role: .destructive) {
                viewModel.deleteList(mediaItems: mediaItems)
            }
        }
        .alert(
            "Rename list",
            isPresented: $viewModel.showRenameAlert
        ) {
            TextField("Name", text: $viewModel.listNewName)
            Button("Cancel", role: .cancel) {
                viewModel.listNewName = ""
            }
            Button("Rename") {
                withAnimation {
                    viewModel.renameList(userList)
                }
            }
        }
    }
}
