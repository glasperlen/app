import SwiftUI
import Magister

struct Bead: View {
    let bead: Magister.Bead
    @State private var offset = CGFloat()
    
    var body: some View {
        ZStack {
            Point(point: bead[.top])
                .offset(y: -offset)
            Point(point: bead[.bottom])
                .offset(y: offset)
            Point(point: bead[.left])
                .offset(x: -offset)
            Point(point: bead[.right])
                .offset(x: offset)
            Color(color: bead.color.color)
                .padding()
        }
        .font(.caption2)
        .foregroundColor(.white)
        .onAppear {
            withAnimation(.easeInOut(duration: 1)) {
                offset = 38
            }
        }
    }
}
