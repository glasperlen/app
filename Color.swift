import SwiftUI
import Magister

extension Color {
    static let background = Color(red: 0.08, green: 0.09, blue: 0.1)
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
