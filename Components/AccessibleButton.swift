// Components/AccessibleButton.swift
// EarnIt Board
//
// Button with large tap target and accessibility label

import SwiftUI

struct AccessibleButton<Label: View>: View {
    let action: () -> Void
    let label: () -> Label
    let accessibilityLabel: String
    
    var body: some View {
        Button(action: action) {
            label()
                .frame(maxWidth: .infinity, minHeight: 48)
        }
        .contentShape(Rectangle())
        .accessibilityLabel(accessibilityLabel)
    }
}
