import SwiftUI

struct Pack: View {
    let beads: [Session.Bead]
    @State private var zoom = false
    @Namespace private var animation
    
    var body: some View {
        Group {
            if zoom {
                VStack {
                    HStack {
                        Bead(bead: beads[0].item)
                            .matchedGeometryEffect(id: "0", in: animation)
                        Bead(bead: beads[1].item)
                            .matchedGeometryEffect(id: "1", in: animation)
                    }
                    HStack {
                        Bead(bead: beads[2].item)
                            .matchedGeometryEffect(id: "2", in: animation)
                        Bead(bead: beads[3].item)
                            .matchedGeometryEffect(id: "3", in: animation)
                        Bead(bead: beads[4].item)
                            .matchedGeometryEffect(id: "4", in: animation)
                    }
                }
            } else {
                VStack {
                    HStack {
                        Bead.Base(color: beads[0].item.color.color)
                            .matchedGeometryEffect(id: "0", in: animation)
                            .frame(width: 15, height: 15)
                        Bead.Base(color: beads[1].item.color.color)
                            .matchedGeometryEffect(id: "1", in: animation)
                            .frame(width: 15, height: 15)
                    }
                    HStack {
                        Bead.Base(color: beads[2].item.color.color)
                            .matchedGeometryEffect(id: "2", in: animation)
                            .frame(width: 15, height: 15)
                        Bead.Base(color: beads[3].item.color.color)
                            .matchedGeometryEffect(id: "3", in: animation)
                            .frame(width: 15, height: 15)
                        Bead.Base(color: beads[4].item.color.color)
                            .matchedGeometryEffect(id: "4", in: animation)
                            .frame(width: 15, height: 15)
                    }
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
                zoom.toggle()
            }
        }
    }
}
