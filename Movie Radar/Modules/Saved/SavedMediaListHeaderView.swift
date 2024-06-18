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
            VStack {
                HStack(spacing: 10) {
                    Image(systemName: userList.imageName ?? "")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(userList.colorInfo?.color ?? .white)
                        .frame(width: 20, height: 20)
                    Text(userList.title ?? "")
                        .lineLimit(5)
                        .font(.system(size: 25, weight: .light))
                        .shadow(radius: 1)
                        .multilineTextAlignment(.center)
                }
                
                Button {
                    withAnimation(.spring) {
                        viewModel.showUserLists.toggle()
                    }
                } label: {
                    Text("My lists")
                        .font(.system(size: 16))
                        .frame(height: 40)
                        .padding(.horizontal, 20)
                        .clipShape(Capsule())
                        .background(
                            Capsule()
                                .fill(.regularMaterial)
                        )
                }
                .padding(.bottom, 30)
                
                HStack {
                    Text("\(mediaItems.count)")
                        .font(.system(size: 50, weight: .semibold))
                        .shadow(radius: 2)
                    Text(mediaItems.count != 1 ? "items" : "item")
                        .shadow(radius: 2)
                }
                .padding()
                
                HStack {
                    Button {
                    } label: {
                        VStack {
                            Image(systemName: "trash.fill")
                                .scaledToFit()
                                .frame(width: 55, height: 55)
                                .background(.regularMaterial)
                                .clipShape(Circle())
                            Text("Delete")
                                .font(.system(size: 14))
                                .shadow(radius: 1)
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                    } label: {
                        VStack {
                            Image(systemName: "paintpalette.fill")
                                .scaledToFit()
                                .frame(width: 55, height: 55)
                                .background(.regularMaterial)
                                .clipShape(Circle())
                            Text("Appearance")
                                .font(.system(size: 14))
                                .shadow(radius: 1)
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                    } label: {
                        VStack {
                            Image(systemName: "pencil")
                                .scaledToFit()
                                .frame(width: 55, height: 55)
                                .background(.regularMaterial)
                                .clipShape(Circle())
                            Text("Rename")
                                .font(.system(size: 14))
                                .shadow(radius: 1)
                        }
                    }
                    
                    Spacer()

                    Button {
                        viewModel.showFilters.toggle()
                    } label: {
                        VStack {
                            Image(systemName: "line.3.horizontal.decrease")
                                .scaledToFit()
                                .frame(width: 55, height: 55)
                                .background(.regularMaterial)
                                .clipShape(Circle())
                            Text("Filter")
                                .font(.system(size: 14))
                                .shadow(radius: 1)
                        }
                    }
                }
                .padding(.horizontal, 12)
            }
            .padding(.vertical)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.horizontal)
        }
        .disabled(viewModel.showUserLists)
        .padding(.bottom, 10)
        .padding(.top)
    }
}
