// Features/RewardEditView.swift
// EarnIt Board
//
// Add/edit reward sheet

import SwiftUI
import SwiftData

struct RewardEditView: View {
    @Environment(\.dismiss) private var dismiss
    var kid: Kid
    var reward: Reward?
    
    @State private var title: String = ""
    @State private var note: String = ""
    @State private var pointCost: Int = 1
    @State private var isActive: Bool = true
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Reward Info")) {
                    TextField("Title", text: $title)
                        .accessibilityLabel("Reward title")
                    TextField("Note", text: $note)
                        .accessibilityLabel("Reward note")
                    Stepper(value: $pointCost, in: 1...999) {
                        Text("Point Cost: \(pointCost)")
                    }
                    .accessibilityLabel("Reward point cost")
                    Toggle("Active", isOn: $isActive)
                        .accessibilityLabel("Reward active")
                }
            }
            .navigationTitle(reward == nil ? "Add Reward" : "Edit Reward")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { saveReward() }
                        .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .onAppear {
                if let reward = reward {
                    title = reward.title
                    note = reward.note ?? ""
                    pointCost = reward.pointCost
                    isActive = reward.isActive
                }
            }
        }
    }
    
    private func saveReward() {
        let context = kid.modelContext ?? ModelContext(EarnItModelContainer.shared.container)
        if let reward = reward {
            reward.title = title
            reward.note = note.isEmpty ? nil : note
            reward.pointCost = pointCost
            reward.isActive = isActive
        } else {
            let newReward = Reward(kid: kid, title: title, note: note.isEmpty ? nil : note, pointCost: pointCost, isActive: isActive, sortOrder: kid.rewards?.count ?? 0)
            context.insert(newReward)
        }
        dismiss()
    }
}

#Preview {
    RewardEditView(kid: .init(name: "Ava", avatarEmoji: "🦄", avatarColor: "pink", startingPoints: 10))
}
