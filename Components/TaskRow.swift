// Components/TaskRow.swift
// EarnIt Board
//
// Row for task in list

import SwiftUI

struct TaskRow: View {
    let task: Task
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: task.isActive ? "checkmark.circle" : "circle")
                .foregroundStyle(task.isActive ? .accent : .secondary)
                .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 2) {
                Text(task.title)
                    .font(.headline)
                if let note = task.note, !note.isEmpty {
                    Text(note)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            Spacer()
            Text("\(task.points)")
                .font(.body)
                .foregroundStyle(.primary)
                .accessibilityLabel("\(task.points) points")
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(task.title), \(task.points) points")
    }
}

#Preview {
    TaskRow(task: .init(kid: .init(name: "Ava", avatarEmoji: "🦄", avatarColor: "pink", startingPoints: 10), title: "Feed the cat", note: "Morning chore", points: 2))
}
