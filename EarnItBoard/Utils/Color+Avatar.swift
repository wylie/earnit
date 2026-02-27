// Utils/Color+Avatar.swift
// EarnIt Board
//
// Helper for avatar color from string

import SwiftUI

extension Color {
    static func avatarColor(_ name: String) -> Color {
        switch name {
        case "blue": return .blue
        case "pink": return .pink
        case "green": return .green
        case "orange": return .orange
        case "purple": return .purple
        case "gray": return .gray
        default: return .accentColor
        }
    }
}
