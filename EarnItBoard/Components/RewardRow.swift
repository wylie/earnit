// Components/RewardRow.swift
// EarnIt Board
//
// Row for reward in list, with redeem button

import SwiftUI

struct RewardRow: View {
    let reward: Reward
    let kid: Kid
    @State private var showConfirm = false
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "gift")
                .foregroundStyle(.accent)
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 2) {
                Text(reward.title)
                    .font(.headline)
                if let note = reward.note, !note.isEmpty {
                    Text(note)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
            Text("\(reward.pointCost)")
                .font(.body)
                .foregroundStyle(.primary)
                .accessibilityLabel("\(reward.pointCost) points")
            if canAfford {
                Button {
                    showConfirm = true
                } label: {
                    Image(systemName: "checkmark.seal")
                        .foregroundStyle(.green)
                        .accessibilityLabel("Redeem reward")
                }
                .buttonStyle(.plain)
                .alert("Redeem \(reward.title)?", isPresented: $showConfirm) {
                    Button("Redeem", role: .destructive) { redeem() }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("This will subtract \(reward.pointCost) points from \(kid.name).")
                }
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(reward.title), \(reward.pointCost) points")
    }
    
    private var canAfford: Bool {
        let currentPoints = kid.startingPoints + (kid.events?.reduce(0) { $0 + $1.pointsDelta } ?? 0)
        return reward.isActive && currentPoints >= reward.pointCost
    }
    
    private func redeem() {
        let context = reward.modelContext ?? ModelContext(EarnItModelContainer.shared.container)
        let event = Event(kid: kid, type: .redemption, reward: reward, pointsDelta: -reward.pointCost)
        context.insert(event)
    }
}

#Preview {
    RewardRow(reward: .init(kid: .init(name: "Ava", avatarEmoji: "🦄", avatarColor: "pink", startingPoints: 10), title: "Ice Cream", pointCost: 5), kid: .init(name: "Ava", avatarEmoji: "🦄", avatarColor: "pink", startingPoints: 10))
}
