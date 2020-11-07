import SwiftUI
import Magister

struct Bead: View {
    let bead: Magister.Bead
    @State private var offset = CGFloat()
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Point(point: bead[.top])
                    .offset(y: -offset * geo.size.width)
                Point(point: bead[.bottom])
                    .offset(y: offset * geo.size.width)
                Point(point: bead[.left])
                    .offset(x: -offset * geo.size.width)
                Point(point: bead[.right])
                    .offset(x: offset * geo.size.width)
                Color(color: bead.color.color)
                    .padding()
            }
        }
        .font(.caption2)
        .foregroundColor(.white)
        .onAppear {
            withAnimation(.easeInOut(duration: 1)) {
                offset = 0.45
            }
        }
    }
}
