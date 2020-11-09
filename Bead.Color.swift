import SwiftUI

extension Bead {
    struct Color: View {
        let color: SwiftUI.Color
        
        var body: some View {
            GeometryReader { geo in
                Circle()
                    .fill(color)
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
