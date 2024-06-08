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
        @Binding var showDetail: Bool
        @Binding var selectedListIndex: Int
        
        @Published var tabIndex = 0
        @Published var listIcon = "star.fill"
        @Published var listName = ""
        @Published var listColor = Color.white
        @Published var isSelectingNewIcon = false
        @Published var isEditing = false
        @Published var showToast = false
        @Published var toastInfo: ToastInfo? {
            didSet {
                withAnimation(.spring) {
                    showToast.toggle()
                }
            }
        }
        
        var localStorage: LocalStorage
        
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
            self._showDetail = showDetail
            self._selectedListIndex = selectedListIndex
            self.localStorage = LocalStorage(modelContext: modelContext)
        }
        
        func createList(currentLists: [UserList]) {
            guard !currentLists.contains(where: { $0.title == listName }) else {
                return
            }
            
            let userList = UserList(
                title: listName,
                imageName: listIcon,
                index: (currentLists.last?.index ?? 0) + 1,
                listType: .myLists,
                colorInfo: .init(color: listColor)
            )
            
            localStorage.insert(list: userList)
            
            listName = ""
            listIcon = "star.fill"
            listColor = .white
            toastInfo = .init(isRemoved: false)
        }
        
        func deleteList(
            _ list: UserList,
            mediaItems: [SavedMedia]
        ) {
            localStorage.delete(
                list: list,
                mediaItems: mediaItems
            )
            withAnimation {
                isEditing = false
            }
            toastInfo = .init(isRemoved: true)
        }
        
        func dismiss() {
            withAnimation(.bouncy(duration: 0.3)) {
                showDetail = false
            }
        }
        
        func isNameInUse(lists: [UserList]) -> Bool {
            let currentListNames = lists.compactMap { $0.title?.lowercased() }
            return currentListNames.contains(listName.lowercased())
        }
    }
}
