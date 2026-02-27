// Features/HistoryUndo.swift
// EarnIt Board
//
// Undo affordance for recent events in history

import SwiftUI
import SwiftData

struct HistoryUndoButton: View {
    let event: Event
    @State private var showConfirm = false
    
    var body: some View {
        if canUndo {
            Button {
                showConfirm = true
            } label: {
                Image(systemName: "arrow.uturn.backward")
                    .foregroundStyle(.blue)
                    .accessibilityLabel("Undo event")
            }
            .buttonStyle(.plain)
            .alert("Undo this event?", isPresented: $showConfirm) {
                Button("Undo", role: .destructive) { undo() }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("This will remove the event and restore points.")
            }
        }
    }
    
    private var canUndo: Bool {
        // Allow undo for events in last 24h
        Calendar.current.dateComponents([.hour], from: event.timestamp, to: Date()).hour ?? 0 < 24
    }
    
    private func undo() {
        if let context = event.modelContext {
            context.delete(event)
        }
    }
}
