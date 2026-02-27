// Utils/PointsCalculator.swift
// EarnIt Board
//
// Helper for computing current points and affordable rewards

import Foundation

struct PointsCalculator {
    static func currentPoints(for kid: Kid) -> Int {
        kid.startingPoints + (kid.events?.reduce(0) { $0 + $1.pointsDelta } ?? 0)
    }
    
    static func affordableRewards(for kid: Kid) -> [Reward] {
        let points = currentPoints(for: kid)
        return (kid.rewards ?? []).filter { $0.isActive && points >= $0.pointCost }
    }
}
