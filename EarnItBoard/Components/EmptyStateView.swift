// EmptyStateView.swift
// EarnIt Board
//
// Shared empty state view for lists/tabs

import SwiftUI

struct EmptyStateView: View {
    let title: String
    let message: String
    let systemImage: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: systemImage)
                .font(.system(size: 48, weight: .light))
                .foregroundStyle(.secondary)
                .accessibilityHidden(true)
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
            Text(message)
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .multilineTextAlignment(.center)
        .padding()
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    EmptyStateView(title: "No Data", message: "Nothing to show yet.", systemImage: "tray")
}
