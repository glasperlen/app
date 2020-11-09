import SwiftUI
import Magister

struct Bead: View {
    let bead: Magister.Bead
    @State private var offset = CGFloat()
    
    var body: some View {
        ZStack {
            Base(color: bead.color.color)
                .frame(width: 16, height: 16)
            Point(point: bead[.top])
                .offset(y: -offset)
            Point(point: bead[.bottom])
                .offset(y: offset)
            Point(point: bead[.left])
                .offset(x: -offset)
            Point(point: bead[.right])
                .offset(x: offset)
        }
        .frame(width: 80, height: 80)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.5)) {
                offset = 22
            }
        }
    }
}
