// HistoryView.swift
// EarnIt Board
//
// History tab: event list, filters, undo

import SwiftUI
import SwiftData

struct HistoryView: View {
    @Query(sort: [SortDescriptor(\.timestamp, order: .reverse)]) private var events: [Event]
    @State private var selectedKidID: UUID?
    @State private var dateFilter: DateFilter = .today
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HistoryFilters(selectedKidID: $selectedKidID, dateFilter: $dateFilter)
                if filteredEvents.isEmpty {
                    EmptyStateView(title: "No Events", message: "No history for this filter.", systemImage: "clock")
                } else {
                    List(filteredEvents) { event in
                        EventRow(event: event)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("History")
        }
    }
    
    private var filteredEvents: [Event] {
        events.filter { event in
            (selectedKidID == nil || event.kid.id == selectedKidID) &&
            dateFilter.contains(event.timestamp)
        }
    }
}

enum DateFilter: String, CaseIterable, Identifiable {
    case today = "Today"
    case last7 = "Last 7 Days"
    case last30 = "Last 30 Days"
    case all = "All Time"
    
    var id: String { rawValue }
    
    func contains(_ date: Date) -> Bool {
        let calendar = Calendar.current
        switch self {
        case .today:
            return calendar.isDateInToday(date)
        case .last7:
            return date >= calendar.date(byAdding: .day, value: -6, to: Date())!
        case .last30:
            return date >= calendar.date(byAdding: .day, value: -29, to: Date())!
        case .all:
            return true
        }
    }
}

#Preview {
    HistoryView()
}
