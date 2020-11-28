import SwiftUI
import GameKit
import Magister

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

extension Match.State {
    func color(_ session: Session) -> Color {
        session.me == self ? .init("User") : .init("Opponent")
    }
}
