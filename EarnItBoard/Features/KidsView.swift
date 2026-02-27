// KidsView.swift
// EarnIt Board
//
// Kids tab: list, add/edit kid, navigate to kid detail (tasks)

import SwiftUI
import SwiftData

struct KidsView: View {
    @Query(sort: [SortDescriptor(\.createdAt)]) private var kids: [Kid]
    @State private var showAddKid = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(kids) { kid in
                    NavigationLink(destination: KidDetailView(kid: kid)) {
                        KidRow(kid: kid)
                    }
                }
                .onDelete(perform: deleteKids)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Kids")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddKid = true
                    } label: {
                        Image(systemName: "plus")
                            .accessibilityLabel("Add Kid")
                    }
                }
            }
            .sheet(isPresented: $showAddKid) {
                KidEditView()
            }
            if kids.isEmpty {
                EmptyStateView(title: "No Kids", message: "Tap + to add a kid.", systemImage: "person.crop.circle.badge.plus")
            }
        }
    }
    
    private func deleteKids(at offsets: IndexSet) {
        for index in offsets {
            let kid = kids[index]
            if let context = kid.modelContext {
                context.delete(kid)
            }
        }
    }
}

#Preview {
    KidsView()
}
