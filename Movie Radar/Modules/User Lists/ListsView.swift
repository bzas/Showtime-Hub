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
                SortDescriptor(\UserList.title)
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
                        isSelected: viewModel.selectedListIndex.wrappedValue == userList.index
                    )
                    .onTapGesture {
                        viewModel.selectedListIndex.wrappedValue = userList.index
                        viewModel.dismiss()
                    }
                }
                
                HStack {
                    Text(UserListType.myLists.title)
                        .font(.system(size: 30, weight: .light))
                    Spacer()
                }
                .padding(.top, 30)
                
                if userLists.isEmpty {
                    Text("No lists created yet")
                        .foregroundStyle(.white)
                        .padding()
                } else {
                    ForEach(userLists, id: \.self) { userList in
                        UserListsCellView(
                            userList: userList,
                            isSelected: viewModel.selectedListIndex.wrappedValue == userList.index
                        )
                        .onTapGesture {
                            viewModel.selectedListIndex.wrappedValue = userList.index
                            viewModel.dismiss()
                        }
                    }
                }
                
                Button(action: {
                    withAnimation {
                        viewModel.tabIndex = 1
                    }
                }, label: {
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
                })
                .padding()
            }
        }
        .scrollIndicators(.hidden)
        .padding(25)
        .onTapGesture {
            viewModel.dismiss()
        }
    }
}
