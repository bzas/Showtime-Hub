//
//  SavedMediaListHeaderView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 16/6/24.
//

import SwiftUI
import SwiftData

struct SavedMediaListHeaderView: View {
    @EnvironmentObject var viewModel: SavedMediaView.ViewModel
    var userList: UserList
    var mediaItems: [SavedMedia]
    
    @Query var defaultLists: [UserList]
    @Query var userLists: [UserList]
        
    init(
        userList: UserList,
        mediaItems: [SavedMedia]
    ) {
        self.userList = userList
        self.mediaItems = mediaItems
        
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
        VStack {
            let itemCountPlaceholder = NSLocalizedString("%d items", comment: "")
            let itemCount = String(
                format: itemCountPlaceholder,
                mediaItems.count
            )
            
            VStack {
                HStack {
                    Menu {
                        ForEach(Array(defaultLists.enumerated()), id: \.1.self) { index, list in
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
                        
                        Menu("My lists") {
                            ForEach(Array(userLists.enumerated()), id: \.1.self) { index, list in
                                Button(action: {
                                    viewModel.selectedTab = defaultLists.count + index
                                }, label: {
                                    HStack {
                                        Label(
                                            list.title ?? "",
                                            systemImage: list.imageName ?? ""
                                        )
                                    }
                                })
                            }
                        }
                    } label: {
                        HStack(spacing: 10) {
                            Image(systemName: userList.imageName ?? "")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(userList.colorInfo?.color ?? .white)
                                .frame(width: 20, height: 20)
                            Text(userList.title ?? "")
                                .lineLimit(1)
                                .font(.system(size: 20, weight: .light))
                            Image(systemName: "chevron.down")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 10, height: 10)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.detailListToShow = userList
                    }, label: {
                        Image(systemName: "gearshape")
                    })
                }
                HStack {
                    Text(itemCount)
                        .bold()
                }
                .padding()
            }
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .padding(.bottom, 10)
    }
}
