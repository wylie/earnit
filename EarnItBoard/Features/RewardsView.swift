// RewardsView.swift
// EarnIt Board
//
// Rewards tab: select kid, list/add/edit/redeem rewards

import SwiftUI
import SwiftData

struct RewardsView: View {
    @Query(sort: [SortDescriptor(\.createdAt)]) private var kids: [Kid]
    @State private var selectedKidID: UUID?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if kids.isEmpty {
                    EmptyStateView(title: "No Kids Yet", message: "Add a kid to manage rewards.", systemImage: "person.crop.circle.badge.plus")
                } else {
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
                    if let kid = selectedKid {
                        RewardsListView(kid: kid)
                    }
                }
            }
            .navigationTitle("Rewards")
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
}

#Preview {
    RewardsView()
}
