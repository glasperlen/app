import SwiftUI
import Magister

struct Bead: View {
    let bead: Magister.Bead
    @State private var offset = CGFloat()
    
    var body: some View {
        ZStack {
            Base(color: bead.color.color)
            Point(point: bead[.top])
                .offset(y: -offset)
            Point(point: bead[.bottom])
                .offset(y: offset)
            Point(point: bead[.left])
                .offset(x: -offset)
            Point(point: bead[.right])
                .offset(x: offset)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.3)) {
                offset = 13
            }
        }
    }
}
