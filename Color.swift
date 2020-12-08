import SwiftUI
import Magister

extension Color {
    static let user = Self("User")
    static let opponent = Self("Opponent")
    static let background = Self("Background")
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
