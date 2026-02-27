// Features/TodayTaskList.swift
// EarnIt Board
//
// Shows active tasks for a kid, allows check-in, undo, and prevents double-completion per day.

import SwiftUI
import SwiftData

struct TodayTaskList: View {
    @ObservedObject var kid: Kid
    @Query private var tasks: [Task]
    @Query private var todayEvents: [Event]
    
    init(kid: Kid) {
        self.kid = kid
        _tasks = Query(filter: #Predicate<Task> { $0.kid.id == kid.id && $0.isActive }, sort: [SortDescriptor(\.sortOrder), SortDescriptor(\.createdAt)])
        let today = Calendar.current.startOfDay(for: Date())
        _todayEvents = Query(filter: #Predicate<Event> { $0.kid.id == kid.id && $0.timestamp >= today })
    }
    
    var body: some View {
        List {
            ForEach(tasks) { task in
                TodayTaskRow(task: task, kid: kid, completed: isCompleted(task: task), onCheck: { complete(task: task) }, onUndo: { undo(task: task) })
            }
        }
        .listStyle(.plain)
    }
    
    private func isCompleted(task: Task) -> Event? {
        todayEvents.first(where: { $0.task?.id == task.id && $0.type == .completion })
    }
    
    private func complete(task: Task) {
        let context = kid.modelContext ?? ModelContext(EarnItModelContainer.shared.container)
        let event = Event(kid: kid, type: .completion, task: task, pointsDelta: task.points)
        context.insert(event)
    }
    
    private func undo(task: Task) {
        if let event = isCompleted(task: task), let context = event.modelContext {
            context.delete(event)
        }
    }
}

struct TodayTaskRow: View {
    let task: Task
    let kid: Kid
    let completed: Event?
    let onCheck: () -> Void
    let onUndo: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Button(action: {
                if completed == nil { onCheck() } else { onUndo() }
            }) {
                Image(systemName: completed == nil ? "circle" : "checkmark.circle.fill")
                    .font(.title2)
                    .foregroundStyle(completed == nil ? .secondary : .green)
                    .scaleEffect(completed == nil ? 1.0 : 1.2)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: completed != nil)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(completed == nil ? "Mark \(task.title) complete" : "Undo \(task.title)")
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
        .contentShape(Rectangle())
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(task.title), \(task.points) points")
    }
}

#Preview {
    TodayTaskList(kid: .init(name: "Ava", avatarEmoji: "🦄", avatarColor: "pink", startingPoints: 10))
}
