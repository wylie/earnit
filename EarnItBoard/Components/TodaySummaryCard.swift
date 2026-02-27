// TodaySummaryCard.swift
// EarnIt Board
//
// Shows current points, today's points, streak placeholder

import SwiftUI
import SwiftData

struct TodaySummaryCard: View {
    @ObservedObject var kid: Kid
    @Query private var events: [Event]
    
    init(kid: Kid) {
        self.kid = kid
        let today = Calendar.current.startOfDay(for: Date())
        _events = Query(filter: #Predicate<Event> { $0.kid.id == kid.id && $0.timestamp >= today })
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Current Points")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(currentPoints)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                    .accessibilityLabel("Current points: \(currentPoints)")
            }
            HStack {
                Text("Today Earned")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
                Text("+\(todayPoints)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.green)
                    .accessibilityLabel("Points earned today: \(todayPoints)")
            }
            HStack {
                Text("Streak")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
                Text("-") // Placeholder
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(uiColor: .systemGray6)))
        .padding(.horizontal)
        .accessibilityElement(children: .combine)
    }
    
    private var currentPoints: Int {
        kid.startingPoints + (kid.events?.reduce(0) { $0 + $1.pointsDelta } ?? 0)
    }
    private var todayPoints: Int {
        events.reduce(0) { $0 + $1.pointsDelta }
    }
}

#Preview {
    TodaySummaryCard(kid: .init(name: "Ava", avatarEmoji: "🦄", avatarColor: "pink", startingPoints: 10))
}
