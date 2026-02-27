// Features/KidDetailView.swift
// EarnIt Board
//
// Kid detail: show/edit kid, list/add/edit/reorder tasks

import SwiftUI
import SwiftData

struct KidDetailView: View {
    @ObservedObject var kid: Kid
    @Query private var tasks: [Task]
    @State private var showEditKid = false
    @State private var showAddTask = false
    
    init(kid: Kid) {
        self.kid = kid
        _tasks = Query(filter: #Predicate<Task> { $0.kid.id == kid.id }, sort: [SortDescriptor(\.sortOrder), SortDescriptor(\.createdAt)])
    }
    
    var body: some View {
        List {
            Section(header: Text("Tasks")) {
                ForEach(tasks) { task in
                    TaskRow(task: task)
                }
                .onDelete(perform: deleteTasks)
                .onMove(perform: moveTasks)
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle(kid.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showEditKid = true
                } label: {
                    Image(systemName: "pencil")
                        .accessibilityLabel("Edit Kid")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddTask = true
                } label: {
                    Image(systemName: "plus")
                        .accessibilityLabel("Add Task")
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
        }
        .sheet(isPresented: $showEditKid) {
            KidEditView(kid: kid)
        }
        .sheet(isPresented: $showAddTask) {
            TaskEditView(kid: kid)
        }
    }
    
    private func deleteTasks(at offsets: IndexSet) {
        for index in offsets {
            let task = tasks[index]
            if let context = task.modelContext {
                context.delete(task)
            }
        }
    }
    
    private func moveTasks(from source: IndexSet, to destination: Int) {
        var reordered = tasks
        reordered.move(fromOffsets: source, toOffset: destination)
        for (i, task) in reordered.enumerated() {
            task.sortOrder = i
        }
    }
}

#Preview {
    KidDetailView(kid: .init(name: "Ava", avatarEmoji: "🦄", avatarColor: "pink", startingPoints: 10))
}
