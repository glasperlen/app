import SwiftUI

extension Bead {
    struct Color: View {
        let color: SwiftUI.Color
        
        var body: some View {
            GeometryReader { geo in
                Circle()
                    .fill(color)
                    .shadow(color: SwiftUI.Color.black.opacity(0.7), radius: geo.size.width / 12)
                    .shadow(color: color.opacity(0.6), radius: geo.size.width / 5)
                    .overlay(
                        Circle()
                            .stroke(SwiftUI.Color.white, lineWidth: geo.size.width / 6)
                            .blur(radius: geo.size.width / 2)
                            .offset(x: geo.size.width / 9, y: geo.size.width / 9)
                            .mask(
                                Circle()
                                    .fill(
                                        LinearGradient(gradient: .init(colors: [.black, .clear]), startPoint: .topLeading, endPoint: .bottomTrailing)
                                    ))
                )
            }
        }
    }
}
