//
//  NetworkMonitor.swift
//  Movie Radar
//
//  Created by Alfonso Boizas Crespo on 30/5/24.
//

import Foundation
import Network

final class NetworkMonitor: ObservableObject {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    var isDisconnected = false {
        didSet {
            Task {
                await MainActor.run {
                    self.objectWillChange.send()
                }
            }
        }
    }
    
    init() {
        networkMonitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                print(
                    String(
                        format: "%@ Network status",
                        path.status == .satisfied ? "✅" : "❌"
                    )
                )
                self.isDisconnected = path.status != .satisfied
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}
