// KidRow.swift
// EarnIt Board
//
// Row for kid in list

import SwiftUI

struct KidRow: View {
    let kid: Kid
    
    var body: some View {
        HStack(spacing: 12) {
            if let emoji = kid.avatarEmoji {
                Text(emoji)
                    .font(.largeTitle)
                    .frame(width: 44, height: 44)
                    .background(Color(uiColor: .systemGray5))
                    .clipShape(Circle())
                    .accessibilityHidden(true)
            } else {
                Circle()
                    .fill(Color(uiColor: .systemGray5))
                    .frame(width: 44, height: 44)
            }
            VStack(alignment: .leading, spacing: 2) {
                Text(kid.name)
                    .font(.headline)
                Text("Points: \(kid.startingPoints)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(kid.name), \(kid.startingPoints) points")
    }
}

#Preview {
    KidRow(kid: .init(name: "Ava", avatarEmoji: "🦄", avatarColor: "pink", startingPoints: 10))
}
