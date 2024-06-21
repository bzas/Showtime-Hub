//
//  MediaContextMenu.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 17/5/24.
//

import SwiftUI
import SwiftData

struct MediaContextMenu: View {
    let apiService: APIService
    let media: Media
    let mediaType: MediaType
    @Binding var toastInfo: ToastInfo?

    @Environment(\.modelContext) var modelContext
    
    @Query var mediaItems: [SavedMedia]
    @Query var defaultLists: [UserList]
    @Query var userLists: [UserList]

    init(
        apiService: APIService,
        media: Media,
        mediaType: MediaType,
        toastInfo: Binding<ToastInfo?>
    ) {
        self.apiService = apiService
        self.media = media
        self.mediaType = mediaType
        self._toastInfo = toastInfo
        
        _mediaItems = Query(
            filter: #Predicate<SavedMedia> {
                $0.detail.id == media.id
            },
            sort: [
                SortDescriptor(\SavedMedia.detail.name)
            ]
        )
        
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
        ForEach(defaultLists, id: \.self) { userList in
            menuButton(userList)
        }
        
        Menu("My lists") {
            ForEach(userLists, id: \.self) { userList in
                menuButton(userList)
            }
        }
    }
    
    @ViewBuilder
    func menuButton(_ userList: UserList) -> some View {
        Button(role: buttonRole(userList: userList)) {
            addOrRemove(userList: userList)
        } label: {
            if let associatedType = SavedType.allCases.first(where: { $0.index == userList.index }) {
                Label(
                    isSaved(userList: userList) ? associatedType.removeActionName : associatedType.addActionName,
                    systemImage: isSaved(userList: userList) ? associatedType.fillImageName : associatedType.imageName
                )
            } else {
                Text(userList.actionTitle(isSaved: isSaved(userList: userList)))
            }
        }
    }
    
    func buttonRole(userList: UserList) -> ButtonRole? {
        isSaved(userList: userList) ? .destructive : nil
    }
    
    func addOrRemove(userList: UserList) {
        let isSaved = isSaved(userList: userList)
        if isSaved {
            remove(userList: userList)
        } else {
            insert(userList: userList)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            toastInfo = .init(
                isSaved: isSaved,
                userList: userList
            )
        }
    }
    
    func isSaved(userList: UserList) -> Bool {
        mediaItems.contains {
            $0.detail.id == media.id && $0.userList == userList
        }
    }
    
    func insert(userList: UserList) {
        Task {
            guard let mediaDetail = await apiService.getDetail(type: mediaType, id: media.id) else { return }
            let storage = LocalStorage(modelContext: modelContext)
            await MainActor.run {
                storage.insert(
                    media: mediaDetail,
                    type: mediaType,
                    userList: userList
                )
            }
        }
    }
    
    func remove(userList: UserList) {
        let storage = LocalStorage(modelContext: modelContext)
        storage.delete(
            media: media,
            mediaType: mediaType,
            userList: userList,
            list: mediaItems
        )
    }
}
