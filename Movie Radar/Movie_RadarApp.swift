//
//  Movie_RadarApp.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 23/4/24.
//

import SwiftUI
import SwiftData

@main
struct Movie_RadarApp: App {
    @StateObject var networkMonitor = NetworkMonitor()
    let container: ModelContainer

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(networkMonitor)
        }
        .modelContainer(container)
    }
    
    init() {
        do {
            container = try ModelContainer(
                for: SavedMedia.self,
                UserList.self
            )
            
            let listsFetchDescriptor = FetchDescriptor<UserList>()
            let mediaFetchDescriptor = FetchDescriptor<SavedMedia>()
            if try container.mainContext.fetch(listsFetchDescriptor).isEmpty {
                SavedType.defaultLists.forEach {
                    container.mainContext.insert($0)
                }
                    
                (try? container.mainContext.fetch(mediaFetchDescriptor))?.forEach {
                    savedMedia in
                    if let list = (try? container.mainContext.fetch(listsFetchDescriptor))?.first(where: { $0.index == savedMedia.savedType.index }) {
                        savedMedia.userList = list
                    }
                }
            }
        } catch {
            fatalError("Failed to create ModelContainer")
        }
    }
}
