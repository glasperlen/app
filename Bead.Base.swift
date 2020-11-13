import SwiftUI

extension Bead {
    struct Base: View {
        let color: Color
        
        var body: some View {
            Circle()
            .fill(color)
            .overlay(
                Circle()
                    .fill(Color.background.opacity(0.35))
                    .blur(radius: 6)
            )
            .frame(width: 54, height: 54)
        }
    }
}
