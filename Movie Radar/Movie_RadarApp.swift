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
            container = try ModelContainer(for: SavedMedia.self)
        } catch {
            fatalError("Failed to create ModelContainer")
        }
    }
}
