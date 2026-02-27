// Features/RewardsListView.swift
// EarnIt Board
//
// List/add/edit/redeem rewards for a kid

import SwiftUI
import SwiftData

struct RewardsListView: View {
    @ObservedObject var kid: Kid
    @Query private var rewards: [Reward]
    @State private var showAddReward = false
    
    init(kid: Kid) {
        self.kid = kid
        _rewards = Query(filter: #Predicate<Reward> { $0.kid.id == kid.id }, sort: [SortDescriptor(\.sortOrder), SortDescriptor(\.createdAt)])
    }
    
    var body: some View {
        List {
            ForEach(rewards) { reward in
                RewardRow(reward: reward, kid: kid)
            }
            .onDelete(perform: deleteRewards)
            .onMove(perform: moveRewards)
        }
        .listStyle(.insetGrouped)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAddReward = true
                } label: {
                    Image(systemName: "plus")
                        .accessibilityLabel("Add Reward")
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
        }
        .sheet(isPresented: $showAddReward) {
            RewardEditView(kid: kid)
        }
    }
    
    private func deleteRewards(at offsets: IndexSet) {
        for index in offsets {
            let reward = rewards[index]
            if let context = reward.modelContext {
                context.delete(reward)
            }
        }
    }
    
    private func moveRewards(from source: IndexSet, to destination: Int) {
        var reordered = rewards
        reordered.move(fromOffsets: source, toOffset: destination)
        for (i, reward) in reordered.enumerated() {
            reward.sortOrder = i
        }
    }
}

#Preview {
    RewardsListView(kid: .init(name: "Ava", avatarEmoji: "🦄", avatarColor: "pink", startingPoints: 10))
}
