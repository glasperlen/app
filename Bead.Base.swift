import SwiftUI

extension Bead {
    struct Base: View {
        let color: Color
        
        var body: some View {
            Circle()
                .fill(color)
                .overlay(
                    Circle()
                        .fill(Color.background.opacity(0.3))
                        .blur(radius: 3)
                        .mask(
                            Circle()
                                .fill(
                                    LinearGradient(gradient: .init(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
                                ))
            )
        }
    }
}
