import SwiftUI
import Magister

struct Bead: View {
    let bead: Magister.Bead
    
    var body: some View {
        ZStack {
            Base(color: bead.color.color)
            Point(point: bead[.top])
                .offset(y: -12)
            Point(point: bead[.bottom])
                .offset(y: 12)
            Point(point: bead[.left])
                .offset(x: -12)
            Point(point: bead[.right])
                .offset(x: 12)
        }
        .frame(width: 54, height: 54)
    }
}
