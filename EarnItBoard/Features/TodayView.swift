// TodayView.swift
// EarnIt Board
//
// Main Today tab: kid picker, summary, active tasks, check-in UI.

import SwiftUI
import SwiftData

struct TodayView: View {
    @Query(sort: [SortDescriptor(\.createdAt)]) private var kids: [Kid]
    @State private var selectedKidID: UUID?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if kids.isEmpty {
                    EmptyStateView(title: "No Kids Yet", message: "Add a kid to get started.", systemImage: "person.crop.circle.badge.plus")
                } else {
                    kidPicker
                    if let kid = selectedKid {
                        TodaySummaryCard(kid: kid)
                        TodayTaskList(kid: kid)
                    }
                }
            }
            .navigationTitle("Today")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: KidsView()) {
                        Image(systemName: "person.3")
                            .accessibilityLabel("Manage Kids")
                    }
                }
            }
        }
        .onAppear {
            if selectedKidID == nil, let first = kids.first?.id {
                selectedKidID = first
            }
        }
    }
    
    private var selectedKid: Kid? {
        kids.first(where: { $0.id == selectedKidID })
    }
    
    private var kidPicker: some View {
        Picker("Kid", selection: $selectedKidID) {
            ForEach(kids) { kid in
                HStack {
                    if let emoji = kid.avatarEmoji {
                        Text(emoji)
                    }
                    Text(kid.name)
                }
                .tag(kid.id as UUID?)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
        .accessibilityLabel("Select kid")
    }
}

#Preview {
    TodayView()
}
