import SwiftUI

struct Neumorphic: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black.opacity(0.5), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.04), radius: 4, x: -4, y: -4)
    }
}
