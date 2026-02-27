// EarnIt Board
// SwiftData + CloudKit ModelContainer setup
//
// This file configures the SwiftData ModelContainer for iCloud sync.
//
// Usage: Call EarnItModelContainer.shared.container in your App struct.

import Foundation
import SwiftData

@MainActor
struct EarnItModelContainer {
    static let shared = EarnItModelContainer()
    let container: ModelContainer
    
    private init() {
        let schema = Schema([
            Kid.self,
            Task.self,
            Reward.self,
            Event.self
        ])
        let config = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false,
            cloudKitDatabase: .automatic
        )
        do {
            container = try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
}
