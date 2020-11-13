import SwiftUI

extension Bead {
    struct Base: View {
        let color: Color
        
        var body: some View {
            Circle()
            .fill(color)
            .overlay(
                Circle()
                    .fill(Color.black.opacity(0.5))
                    .blur(radius: 7)
            )
            .frame(width: 54, height: 54)
        }
    }
}
