// EarnIt Board
// SwiftData Models
//
// Defines all SwiftData models for the EarnIt Board app.
//
// - Kid
// - Task
// - Reward
// - Event
//
// Data is stored locally and synced via iCloud using SwiftData + CloudKit.

import Foundation
import SwiftData

@Model
final class Kid: Identifiable {
    @Attribute(.unique) var id: UUID
    var name: String
    var avatarEmoji: String?
    var avatarColor: String
    var startingPoints: Int
    var createdAt: Date
    
    @Relationship(deleteRule: .cascade, inverse: \Task.kid) var tasks: [Task] = []
    @Relationship(deleteRule: .cascade, inverse: \Reward.kid) var rewards: [Reward] = []
    @Relationship(deleteRule: .cascade, inverse: \Event.kid) var events: [Event] = []
    
    init(id: UUID = UUID(), name: String, avatarEmoji: String? = nil, avatarColor: String, startingPoints: Int, createdAt: Date = Date()) {
        self.id = id
        self.name = name
        self.avatarEmoji = avatarEmoji
        self.avatarColor = avatarColor
        self.startingPoints = startingPoints
        self.createdAt = createdAt
    }
}

@Model
final class Task: Identifiable {
    @Attribute(.unique) var id: UUID
    @Relationship var kid: Kid
    var title: String
    var note: String?
    var points: Int
    var isActive: Bool
    var sortOrder: Int
    var createdAt: Date
    
    init(id: UUID = UUID(), kid: Kid, title: String, note: String? = nil, points: Int, isActive: Bool = true, sortOrder: Int = 0, createdAt: Date = Date()) {
        self.id = id
        self.kid = kid
        self.title = title
        self.note = note
        self.points = points
        self.isActive = isActive
        self.sortOrder = sortOrder
        self.createdAt = createdAt
    }
}

@Model
final class Reward: Identifiable {
    @Attribute(.unique) var id: UUID
    @Relationship var kid: Kid
    var title: String
    var note: String?
    var pointCost: Int
    var isActive: Bool
    var sortOrder: Int
    var createdAt: Date
    
    init(id: UUID = UUID(), kid: Kid, title: String, note: String? = nil, pointCost: Int, isActive: Bool = true, sortOrder: Int = 0, createdAt: Date = Date()) {
        self.id = id
        self.kid = kid
        self.title = title
        self.note = note
        self.pointCost = pointCost
        self.isActive = isActive
        self.sortOrder = sortOrder
        self.createdAt = createdAt
    }
}

enum EventType: String, Codable, CaseIterable {
    case completion
    case redemption
    case adjustment
}

@Model
final class Event: Identifiable {
    @Attribute(.unique) var id: UUID
    @Relationship var kid: Kid
    var type: EventType
    @Relationship var task: Task?
    @Relationship var reward: Reward?
    var pointsDelta: Int
    var timestamp: Date
    var createdAt: Date
    
    init(id: UUID = UUID(), kid: Kid, type: EventType, task: Task? = nil, reward: Reward? = nil, pointsDelta: Int, timestamp: Date = Date(), createdAt: Date = Date()) {
        self.id = id
        self.kid = kid
        self.type = type
        self.task = task
        self.reward = reward
        self.pointsDelta = pointsDelta
        self.timestamp = timestamp
        self.createdAt = createdAt
    }
}
