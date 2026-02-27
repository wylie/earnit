// Features/TaskEditView.swift
// EarnIt Board
//
// Add/edit task sheet

import SwiftUI
import SwiftData

struct TaskEditView: View {
    @Environment(\.dismiss) private var dismiss
    var kid: Kid
    var task: Task?
    
    @State private var title: String = ""
    @State private var note: String = ""
    @State private var points: Int = 1
    @State private var isActive: Bool = true
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Task Info")) {
                    TextField("Title", text: $title)
                        .accessibilityLabel("Task title")
                    TextField("Note", text: $note)
                        .accessibilityLabel("Task note")
                    Stepper(value: $points, in: 1...100) {
                        Text("Points: \(points)")
                    }
                    .accessibilityLabel("Task points")
                    Toggle("Active", isOn: $isActive)
                        .accessibilityLabel("Task active")
                }
            }
            .navigationTitle(task == nil ? "Add Task" : "Edit Task")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { saveTask() }
                        .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .onAppear {
                if let task = task {
                    title = task.title
                    note = task.note ?? ""
                    points = task.points
                    isActive = task.isActive
                }
            }
        }
    }
    
    private func saveTask() {
        let context = kid.modelContext ?? ModelContext(EarnItModelContainer.shared.container)
        if let task = task {
            task.title = title
            task.note = note.isEmpty ? nil : note
            task.points = points
            task.isActive = isActive
        } else {
            let newTask = Task(kid: kid, title: title, note: note.isEmpty ? nil : note, points: points, isActive: isActive, sortOrder: kid.tasks?.count ?? 0)
            context.insert(newTask)
        }
        dismiss()
    }
}

#Preview {
    TaskEditView(kid: .init(name: "Ava", avatarEmoji: "🦄", avatarColor: "pink", startingPoints: 10))
}
