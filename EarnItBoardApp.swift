// EarnIt Board
// App Entry Point
//
// README
//
// How to run:
// - Open EarnItBoard.xcodeproj in Xcode 15+ (iOS 17 SDK required)
// - Build and run on iPhone/iPad simulator or device
//
// Data storage:
// - Uses SwiftData for local persistence
// - All data is stored on-device and synced to iCloud via CloudKit (default container)
// - No external servers or dependencies
//
// iCloud sync:
// - Requires iCloud capability enabled (CloudKit, default container)
// - Sync is automatic; local changes appear instantly, remote changes merge when available
// - Last-writer-wins for conflicts
// - App works offline and syncs when network is available
//
// Entitlements/config:
// - Enable iCloud + CloudKit in Xcode project capabilities
// - No custom entitlements needed beyond default iCloud
//
// Project structure:
// - Models.swift: SwiftData models
// - ModelContainer.swift: SwiftData + CloudKit setup
// - AppShell.swift: TabView, navigation, adaptive layouts
// - Features/: All feature views (Kids, Tasks, Rewards, Today, History)
// - Components/: Shared UI components
// - Utils/: Helpers, extensions
//
// Next features (not implemented):
// - Widgets
// - Streaks
// - Multiple boards/families
// - Export/share history
// - Subscriptions (no IAP/ads in MVP)

import SwiftUI
import SwiftData

@main
struct EarnItBoardApp: App {
    @StateObject private var syncMonitor = SyncStatusMonitor()
    
    var body: some Scene {
        WindowGroup {
            AppShell()
                .modelContainer(EarnItModelContainer.shared.container)
                .environmentObject(syncMonitor)
        }
    }
}
