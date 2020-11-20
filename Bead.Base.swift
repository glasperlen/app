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
                        .blur(radius: 10)
                        .mask(
                            Circle()
                                .fill(Color.black)
                                .frame(width: 52, height: 52)
                        )
                        
                )
            .frame(width: 54, height: 54)
        }
    }
}
