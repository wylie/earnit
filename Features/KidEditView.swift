// Features/KidEditView.swift
// EarnIt Board
//
// Add/edit kid sheet

import SwiftUI
import SwiftData

struct KidEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Query private var kids: [Kid]
    var kid: Kid?
    
    @State private var name: String = ""
    @State private var avatarEmoji: String = ""
    @State private var avatarColor: String = "blue"
    @State private var startingPoints: Int = 0
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Kid Info")) {
                    TextField("Name", text: $name)
                        .accessibilityLabel("Kid name")
                    TextField("Emoji", text: $avatarEmoji)
                        .accessibilityLabel("Avatar emoji")
                    Picker("Color", selection: $avatarColor) {
                        ForEach(["blue", "pink", "green", "orange", "purple", "gray"], id: \.self) { color in
                            Text(color.capitalized)
                        }
                    }
                    .accessibilityLabel("Avatar color")
                    Stepper(value: $startingPoints, in: -999...999) {
                        Text("Starting Points: \(startingPoints)")
                    }
                    .accessibilityLabel("Starting points")
                }
            }
            .navigationTitle(kid == nil ? "Add Kid" : "Edit Kid")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { saveKid() }
                        .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .onAppear {
                if let kid = kid {
                    name = kid.name
                    avatarEmoji = kid.avatarEmoji ?? ""
                    avatarColor = kid.avatarColor
                    startingPoints = kid.startingPoints
                }
            }
        }
    }
    
    private func saveKid() {
        let context = kids.first?.modelContext ?? ModelContext(
            EarnItModelContainer.shared.container
        )
        if let kid = kid {
            kid.name = name
            kid.avatarEmoji = avatarEmoji.isEmpty ? nil : avatarEmoji
            kid.avatarColor = avatarColor
            kid.startingPoints = startingPoints
        } else {
            let newKid = Kid(name: name, avatarEmoji: avatarEmoji.isEmpty ? nil : avatarEmoji, avatarColor: avatarColor, startingPoints: startingPoints)
            context.insert(newKid)
        }
        dismiss()
    }
}

#Preview {
    KidEditView()
}
