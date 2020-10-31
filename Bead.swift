import SwiftUI

struct Bead: View {
    let color: Color
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                Circle()
                    .fill(color)
                    .shadow(color: Color.black.opacity(0.6), radius: geo.size.width / 10)
                    .shadow(color: color.opacity(0.6), radius: geo.size.width / 3)
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: geo.size.width / 5)
                            .blur(radius: geo.size.width / 4)
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
