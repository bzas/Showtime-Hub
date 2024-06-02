//
//  UserLists+ViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 2/6/24.
//

import SwiftUI
import SwiftData

extension UserListsView {
    class ViewModel: ObservableObject {
        @Published var tabIndex = 0
        @Published var listIcon = "star.fill"
        @Published var listName = ""
        @Published var listColor = Color.white
        @Published var isSelectingNewIcon = false

        var localStorage: LocalStorage
        var showDetail: Binding<Bool>
        var selectedListIndex: Binding<Int>
        
        init(
            tabIndex: Int = 0,
            newListIcon: String = "star.fill",
            newListName: String = "",
            isSelectingNewIcon: Bool = false,
            showDetail: Binding<Bool>,
            selectedListIndex: Binding<Int>,
            modelContext: ModelContext
        ) {
            self.tabIndex = tabIndex
            self.listIcon = newListIcon
            self.listName = newListName
            self.isSelectingNewIcon = isSelectingNewIcon
            self.showDetail = showDetail
            self.selectedListIndex = selectedListIndex
            self.localStorage = LocalStorage(modelContext: modelContext)
        }
        
        func createList(index: Int) {
            let userList = UserList(
                title: listName,
                imageName: listIcon,
                index: index,
                listType: .myLists,
                colorInfo: .init(color: listColor)
            )
            
            localStorage.insert(list: userList)
            
            listName = ""
            listIcon = "star.fill"
            listColor = .white
        }
        
        func dismiss() {
            withAnimation(.bouncy(duration: 0.3)) {
                showDetail.wrappedValue = false
            }
        }
    }
}
