//
//  UserLists+ViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 2/6/24.
//

import SwiftUI
import SwiftData
import EmojiPicker

extension UserListsView {
    class ViewModel: ObservableObject {
        @Binding var showDetail: Bool
        @Binding var selectedListIndex: Int
        
        @Published var showGradient = false
        @Published var tabIndex = 0
        @Published var listIcon = ""
        @Published var listName = ""
        @Published var listEmoji: Emoji?
        @Published var selectedIconType = ListIconType.emoji
        @Published var customImage: UIImage?
        @Published var customBackground: UIImage?
        @Published var listBackgroundType = ListBackground.abstract
        @Published var listBackgroundGenericType = ListBackgroundGenericType.app
        @Published var listBackgroundIndex = 0
        @Published var listColor = Color.white
        @Published var isEditing = false
        @Published var showToast = false
        @Published var toastInfo: ToastInfo? {
            didSet {
                withAnimation(.spring) {
                    showToast = true
                }
            }
        }
        
        var localStorage: LocalStorage
        
        init(
            tabIndex: Int = 0,
            newListIcon: String = "",
            newListName: String = "",
            showDetail: Binding<Bool>,
            selectedListIndex: Binding<Int>,
            modelContext: ModelContext
        ) {
            self.tabIndex = tabIndex
            self.listIcon = newListIcon
            self.listName = newListName
            self._showDetail = showDetail
            self._selectedListIndex = selectedListIndex
            self.localStorage = LocalStorage(modelContext: modelContext)
        }
        
        func createList(currentLists: [UserList]) {
            guard !currentLists.contains(where: { $0.title == listName }) else {
                return
            }
            
            let newIndex = (currentLists.last?.index ?? 0) + 1
            
            var userList: UserList!
            
            switch selectedIconType {
            case .emoji:
                userList = UserList(
                    title: listName,
                    index: newIndex,
                    listType: .myLists,
                    backgroundPath: listBackgroundType.imagePath(index: listBackgroundIndex),
                    emoji: listEmoji?.value,
                    customBackground: listBackgroundGenericType == .upload ? customBackground?.pngData() : nil
                )
            case .systemSymbol:
                userList = UserList(
                    title: listName,
                    imageName: listIcon,
                    index: newIndex,
                    listType: .myLists,
                    colorInfo: .init(color: listColor),
                    backgroundPath: listBackgroundType.imagePath(index: listBackgroundIndex),
                    customBackground: listBackgroundGenericType == .upload ? customBackground?.pngData() : nil
                )
            case .upload:
                userList = UserList(
                    title: listName,
                    imageName: listIcon,
                    index: newIndex,
                    listType: .myLists,
                    colorInfo: .init(color: listColor),
                    backgroundPath: listBackgroundType.imagePath(index: listBackgroundIndex), 
                    customImage: customImage?.pngData(),
                    customBackground: listBackgroundGenericType == .upload ? customBackground?.pngData() : nil
                )
            }
            
            localStorage.insert(list: userList)
            
            listName = ""
            listIcon = ""
            listColor = .white
            listBackgroundType = .abstract
            listBackgroundIndex = 1
            
            selectList(index: currentLists.count)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
                self?.toastInfo = .init(isRemoved: false)
            }
        }
        
        func deleteList(
            _ list: UserList,
            index: Int,
            mediaItems: [SavedMedia]
        ) {
            if (index + SavedType.allCases.count) == selectedListIndex {
                selectedListIndex -= 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
                guard let self else { return }
                localStorage.delete(
                    list: list,
                    mediaItems: mediaItems
                )
                withAnimation {
                    self.isEditing = false
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    self.toastInfo = .init(isRemoved: true)
                }
            }
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
        
        func selectList(index: Int) {
            selectedListIndex = index
            dismiss()
        }
    }
}
