import SwiftUI

struct Neumorphic: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black.opacity(0.7), radius: 12, x: 12, y: 12)
            .shadow(color: Color.white.opacity(0.06), radius: 5, x: -5, y: -5)
    }
}
