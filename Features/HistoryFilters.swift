// Features/HistoryFilters.swift
// EarnIt Board
//
// Kid picker and date filter for history tab

import SwiftUI
import SwiftData

struct HistoryFilters: View {
    @Query(sort: [SortDescriptor(\.createdAt)]) private var kids: [Kid]
    @Binding var selectedKidID: UUID?
    @Binding var dateFilter: DateFilter
    
    var body: some View {
        VStack(spacing: 8) {
            Picker("Kid", selection: $selectedKidID) {
                Text("All Kids").tag(UUID?.none)
                ForEach(kids) { kid in
                    Text(kid.name).tag(kid.id as UUID?)
                }
            }
            .pickerStyle(.segmented)
            .accessibilityLabel("Filter by kid")
            Picker("Date", selection: $dateFilter) {
                ForEach(DateFilter.allCases) { filter in
                    Text(filter.rawValue).tag(filter)
                }
            }
            .pickerStyle(.segmented)
            .accessibilityLabel("Filter by date range")
        }
        .padding(.horizontal)
    }
}

#Preview {
    HistoryFilters(selectedKidID: .constant(nil), dateFilter: .constant(.today))
}
