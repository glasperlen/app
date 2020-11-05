import SwiftUI
import Magister

extension Color {
    static let background = Color(red: 0.07, green: 0.075, blue: 0.08)
    static let user = Color(red: 0.5, green: 0.7, blue: 0.9)
    static let oponent = Color(red: 1, green: 0.4, blue: 0.5)
}

extension Magister.Bead.Color {
    var color: Color {
        switch self {
        case .blue: return .blue
        case .pink: return .pink
        case .red: return .red
        case .orange: return .orange
        case .green: return .green
        case .yellow: return .yellow
        case .teal: return .init(.systemTeal)
        case .purple: return .purple
        case .indigo: return .init(.systemIndigo)
        }
    }
}

extension Magister.Player.Mode {
    var color: Color {
        switch self {
        case .user: return .user
        case .oponent: return .oponent
        case .none: return .clear
        }
    }
}
