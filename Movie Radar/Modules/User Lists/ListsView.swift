//
//  ListsView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 2/6/24.
//

import SwiftUI
import SwiftData

struct ListsView: View {
    @EnvironmentObject var viewModel: UserListsView.ViewModel
    @Query var defaultLists: [UserList]
    @Query var userLists: [UserList]
    @Query var mediaItems: [SavedMedia]

    init() {
        let defaultListTypeString = UserListType.defaultList.rawValue
        _defaultLists = Query(
            filter: #Predicate<UserList> {
                $0._listType == defaultListTypeString
            },
            sort: [
                SortDescriptor(\UserList.index)
            ]
        )
        
        let userListTypeString = UserListType.myLists.rawValue
        _userLists = Query(
            filter: #Predicate<UserList> {
                $0._listType == userListTypeString
            },
            sort: [
                SortDescriptor(\UserList.index)
            ]
        )
    }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text(UserListType.defaultList.title)
                        .font(.system(size: 30, weight: .light))
                    Spacer()
                }
                ForEach(defaultLists, id: \.self) { userList in
                    UserListsCellView(
                        userList: userList,
                        isSelected: viewModel.selectedListIndex == userList.index
                    )
                    .onTapGesture {
                        viewModel.selectList(index: userList.index)
                    }
                }
                
                HStack {
                    Text(UserListType.myLists.title)
                        .font(.system(size: 30, weight: .light))
                    Spacer()
                    if !userLists.isEmpty {
                        Button(viewModel.isEditing ? "Done" : "Edit") {
                            withAnimation {
                                viewModel.isEditing.toggle()
                            }
                        }
                        .padding(.top, 6)
                        .padding(.trailing, 6)
                    }                    
                }
                .padding(.top, 30)
                
                if userLists.isEmpty {
                    Text("No lists created yet")
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    ForEach(Array(userLists.enumerated()), id: \.1.self) { index, userList in
                        let correctedIndex = index + defaultLists.count
                        HStack {
                            if viewModel.isEditing {
                                Button {
                                    viewModel.deleteList(
                                        userList,
                                        index: index,
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
                            
                            UserListsCellView(
                                userList: userList,
                                isSelected: viewModel.selectedListIndex == correctedIndex
                            )
                            .onTapGesture {
                                if !viewModel.isEditing {
                                    viewModel.selectList(index: correctedIndex)
                                }
                            }
                        }
                    }
                }
                
                Button {
                    withAnimation {
                        viewModel.tabIndex = 1
                    }
                } label: {
                    HStack(spacing: 25) {
                        Text("New")
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                    }
                    .foregroundStyle(.black)
                    .padding()
                    .background(.white)
                    .clipShape(Capsule())
                }
                .padding()
                .padding(.bottom, 48)
                
                Spacer()
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, 25)
        .padding(.top, 40)
    }
}
