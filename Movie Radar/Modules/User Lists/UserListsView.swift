//
//  UserListsView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 31/5/24.
//

import SwiftUI
import SwiftData

struct UserListsView: View {
    @Query var defaultLists: [UserList]
    @Query var userLists: [UserList]
    var showDetail: Binding<Bool>
    var selectedListIndex: Binding<Int>

    init(showDetail: Binding<Bool>, selectedListIndex: Binding<Int>) {
        self.showDetail = showDetail
        self.selectedListIndex = selectedListIndex
        
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
                HStack(spacing: 30) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.white)
                            .padding()
                    })
                    Spacer()
                }
                
                LazyVStack {
                    HStack {
                        Text(UserListType.defaultList.title)
                            .font(.system(size: 30, weight: .light))
                        Spacer()
                    }
                    ForEach(defaultLists, id: \.self) { userList in
                        UserListsCellView(
                            userList: userList,
                            isSelected: selectedListIndex.wrappedValue == userList.index
                        )
                        .onTapGesture {
                            selectedListIndex.wrappedValue = userList.index
                            dismiss()
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
                                isSelected: selectedListIndex.wrappedValue == userList.index
                            )
                            .onTapGesture {
                                selectedListIndex.wrappedValue = userList.index
                                dismiss()
                            }
                        }
                    }
                    
                    Button(action: {
                        // TO DO
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
                .padding(25)
            }
        }
        .transition(
            .asymmetric(
                insertion: .scale(scale: 0.01),
                removal: .scale(scale: 0.01)
            )
        )
        .onTapGesture {
            dismiss()
        }
    }
    
    func dismiss() {
        withAnimation(.bouncy(duration: 0.3)) {
            showDetail.wrappedValue = false
        }
    }
}
