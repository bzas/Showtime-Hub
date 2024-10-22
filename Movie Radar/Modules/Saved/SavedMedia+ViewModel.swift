//
//  SavedMedia+ViewModel.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 24/4/24.
//

import SwiftUI
import SwiftData

extension SavedMediaView {
    class ViewModel: ObservableObject {
        var apiService: APIService
        var localStorage: LocalStorage
        @Published var selectedMediaType = MediaType.all
        @Published var selectedTab = 0 {
            didSet {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
                    guard let self else { return }
                    withAnimation(.spring(duration: 0.5)) {
                        self.selectedListIndex = self.selectedTab
                    }
                }
            }
        }
        @Published var selectedListIndex = 0 {
            didSet {
                needsImageReload.toggle()
            }
        }
        @Published var showFilters = false
        @Published var showUserLists = false
        @Published var searchText = ""
        @Published var filtersApplied = false
        @Published var startDate = LocalStorage.defaultDate
        @Published var endDate = LocalStorage.defaultEndDate
        @Published var showDetailMedia = false
        @Published var detailMediaToShow: SavedMedia? {
            didSet {
                showDetailMedia.toggle()
            }
        }
        
        @Published var showToast = false
        @Published var toastInfo: ToastInfo? {
            didSet {
                withAnimation(.spring(duration: 0.3)) {
                    showToast = true
                }
            }
        }
        
        @Published var showDeleteListAlert = false
        @Published var listToDelete: UserList? {
            didSet {
                showDeleteListAlert = listToDelete != nil
            }
        }
        
        @Published var showRenameAlert = false
        @Published var listNewName = "" {
            didSet {
                if !showRenameAlert {
                    showRenameAlert = !listNewName.isEmpty
                }
            }
        }
        
        @Published var showBackgroundEditionView = false {
            didSet {
                if !showBackgroundEditionView {
                    needsImageReload.toggle()
                }
            }
        }
        @Published var backgroundEditionList: UserList? {
            didSet {
                showBackgroundEditionView = backgroundEditionList != nil
            }
        }
        
        @Published var showIconEditionView = false
        @Published var iconEditionList: UserList? {
            didSet {
                showIconEditionView = iconEditionList != nil
            }
        }
        
        @Published var backgroundImage: UIImage?
        @Published var needsImageReload = false

        init(
            apiService: APIService,
            modelContext: ModelContext
        ) {
            self.apiService = apiService
            self.localStorage = LocalStorage(modelContext: modelContext)
        }
        
        func filtersPredicate(userList: UserList) -> Predicate<SavedMedia>? {
            LocalStorage.buildFilterPredicate(
                mediaType: selectedMediaType,
                userList: userList,
                searchText: searchText,
                startDate: startDate,
                endDate: endDate
            )
        }
        
        func deleteList(mediaItems: [SavedMedia]) {
            guard let listToDelete else { return }
            
            withAnimation {
                selectedTab -= 1
            } completion: { [weak self] in
                guard let self else { return }
                
                localStorage.delete(
                    list: listToDelete,
                    mediaItems: mediaItems
                )
                
                self.listToDelete = nil
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    self.toastInfo = .init(isRemoved: true)
                }
            }
        }
        
        func renameList(_ userList: UserList) {
            userList.title = listNewName
            listNewName = ""
        }
        
        func removeFromList(
            media: SavedMedia,
            userList: UserList,
            mediaItems: [SavedMedia]
        ) {
            localStorage.delete(
                media: media.detail,
                mediaType: media.type,
                userList: userList,
                list: mediaItems
            )
        }
        
        func loadBackgroundImage(userLists: [UserList]) {
            Task {                
                if let customBackgroundData = userLists[selectedListIndex].customBackground,
                   let image = UIImage(data: customBackgroundData) {
                    await updateBackgroundImage(image)
                } else {
                    let appBackgroundPath = userLists[selectedListIndex].backgroundPath ?? ListBackground.abstract.imagePath(index: 0)
                    await updateBackgroundImage(UIImage(named: appBackgroundPath))
                }
            }
        }
        
        func updateBackgroundImage(_ image: UIImage?) async {
            await MainActor.run {
                withAnimation {
                    backgroundImage = image
                }
            }
        }
    }
}
