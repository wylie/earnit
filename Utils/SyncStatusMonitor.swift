// Utils/SyncStatusMonitor.swift
// EarnIt Board
//
// Monitors SwiftData/CloudKit sync status (minimal, optional)

import Foundation
import Combine
import SwiftUI

class SyncStatusMonitor: ObservableObject {
    @Published var isSyncing: Bool = false
    // Extend with more sync info if needed
}
