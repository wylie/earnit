// Components/EventRow.swift
// EarnIt Board
//
// Row for event in history list

import SwiftUI

struct EventRow: View {
    let event: Event
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: iconName)
                .foregroundStyle(iconColor)
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.headline)
                Text(event.timestamp, style: .date)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Text(pointsText)
                .font(.body)
                .foregroundStyle(pointsColor)
                .accessibilityLabel("\(event.pointsDelta) points")
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title), \(pointsText)")
    }
    
    private var iconName: String {
        switch event.type {
        case .completion: return "checkmark.circle"
        case .redemption: return "gift"
        case .adjustment: return "arrow.left.arrow.right"
        }
    }
    private var iconColor: Color {
        switch event.type {
        case .completion: return .accentColor
        case .redemption: return .pink
        case .adjustment: return .orange
        }
    }
    private var title: String {
        switch event.type {
        case .completion: return event.task?.title ?? "Task Completed"
        case .redemption: return event.reward?.title ?? "Reward Redeemed"
        case .adjustment: return "Adjustment"
        }
    }
    private var pointsText: String {
        event.pointsDelta > 0 ? "+\(event.pointsDelta)" : "\(event.pointsDelta)"
    }
    private var pointsColor: Color {
        event.pointsDelta >= 0 ? .green : .red
    }
}

#Preview {
    EventRow(event: .init(kid: .init(name: "Ava", avatarEmoji: "🦄", avatarColor: "pink", startingPoints: 10), type: .completion, pointsDelta: 2))
}
