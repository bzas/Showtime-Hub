//
//  SaveMediaStackView.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 19/5/24.
//

import SwiftUI
import SwiftData

struct SaveMediaStackView: View {
    let media: Media
    let mediaType: MediaType
    @State var triggerHapticFeedback = false
    
    @Environment(\.modelContext) var modelContext
    @Query var mediaItems: [SavedMedia]
    @Query var defaultLists: [UserList]
    @Query var userLists: [UserList]
    @Binding var toastInfo: ToastInfo?

    init(
        media: Media,
        mediaType: MediaType,
        toastInfo: Binding<ToastInfo?>
    ) {
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
        HStack {
            content()
        }
        .sensoryFeedback(
            .impact(flexibility: .soft, intensity: 1),
            trigger: triggerHapticFeedback
        )
    }
    
    @ViewBuilder func content() -> some View {
        if !userLists.isEmpty {
            Menu {
                ForEach(userLists, id: \.self) { list in
                    Button(role: buttonRole(userList: list)) {
                        addOrRemove(list: list)
                    } label: {
                        Text(list.actionTitle(isSaved: isSaved(userList: list)))
                    }
                }
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.black.opacity(0.75))
                    .frame(width: 20, height: 20)
                    .padding(8)
                    .background(.white.opacity(0.75))
                    .clipShape(Circle())
                    .shadow(
                        color: .black.opacity(0.75),
                        radius: 2
                    )
            }
        }
        
        HStack {
            ForEach(defaultLists, id: \.self) { list in
                Button {
                    addOrRemove(list: list)
                } label: {
                    SaveMediaButtonView(
                        userList: list,
                        isSaved: isSaved(userList: list)
                    )
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(.white.opacity(0.75))
        .clipShape(Capsule())
        .shadow(
            color: .black.opacity(0.75),
            radius: 2
        )
    }
    
    func buttonRole(userList: UserList) -> ButtonRole? {
        isSaved(userList: userList) ? .destructive : nil
    }
    
    func addOrRemove(list: UserList) {
        let isSaved = isSaved(userList: list)
        if isSaved {
            remove(userList: list)
        } else {
            insert(userList: list)
        }
        
        triggerHapticFeedback.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            toastInfo = .init(
                isSaved: isSaved,
                userList: list
            )
        }
    }
    
    func isSaved(userList: UserList) -> Bool {
        mediaItems.contains {
            $0.detail.id == media.id && $0.userList == userList
        }
    }
    
    func insert(userList: UserList) {
        let storage = LocalStorage(modelContext: modelContext)
        storage.insert(
            media: media,
            type: mediaType,
            userList: userList
        )
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
