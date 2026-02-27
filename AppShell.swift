// AppShell.swift
// EarnIt Board
//
// Main app shell: TabView (iPhone) and adaptive NavigationSplitView (iPad)
//
// Handles navigation, tab bar, and adaptive layouts.

import SwiftUI

struct AppShell: View {
    @Environment(\.horizontalSizeClass) private var hSize
    @Environment(\.verticalSizeClass) private var vSize
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        Group {
            if UIDevice.current.userInterfaceIdiom == .pad {
                iPadShell()
            } else {
                iPhoneShell()
            }
        }
        .onChange(of: scenePhase) { newPhase in
            // Optional: handle background/foreground sync triggers
        }
    }
}

private struct iPhoneShell: View {
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Label("Today", systemImage: "sun.max")
                }
            KidsView()
                .tabItem {
                    Label("Kids", systemImage: "person.3")
                }
            RewardsView()
                .tabItem {
                    Label("Rewards", systemImage: "gift")
                }
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock.arrow.circlepath")
                }
        }
    }
}

private struct iPadShell: View {
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Label("Today", systemImage: "sun.max")
                }
            KidsSplitView()
                .tabItem {
                    Label("Kids", systemImage: "person.3")
                }
            RewardsSplitView()
                .tabItem {
                    Label("Rewards", systemImage: "gift")
                }
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock.arrow.circlepath")
                }
        }
    }
}

// MARK: - Placeholder Views for SplitView

struct KidsSplitView: View {
    var body: some View {
        NavigationSplitView {
            KidsView()
        } detail: {
            KidDetailPlaceholder()
        }
    }
}

struct RewardsSplitView: View {
    var body: some View {
        NavigationSplitView {
            RewardsView()
        } detail: {
            RewardDetailPlaceholder()
        }
    }
}

struct KidDetailPlaceholder: View {
    var body: some View {
        Text("Select a kid")
            .foregroundStyle(.secondary)
            .accessibilityLabel("Select a kid to view details")
    }
}

struct RewardDetailPlaceholder: View {
    var body: some View {
        Text("Select a reward")
            .foregroundStyle(.secondary)
            .accessibilityLabel("Select a reward to view details")
    }
}

// MARK: - Previews

#Preview {
    AppShell()
}
