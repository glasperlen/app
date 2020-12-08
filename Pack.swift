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
                            .frame(width: 15, height: 15)
                            .matchedGeometryEffect(id: "0", in: animation)
                            .frame(width: 54, height: 54)
                        Bead(bead: beads[1].item)
                            .frame(width: 15, height: 15)
                            .matchedGeometryEffect(id: "1", in: animation)
                            .frame(width: 54, height: 54)
                    }
                    HStack {
                        Bead(bead: beads[2].item)
                            .frame(width: 15, height: 15)
                            .matchedGeometryEffect(id: "2", in: animation)
                            .frame(width: 54, height: 54)
                        Bead(bead: beads[3].item)
                            .frame(width: 15, height: 15)
                            .matchedGeometryEffect(id: "3", in: animation)
                            .frame(width: 54, height: 54)
                        Bead(bead: beads[4].item)
                            .frame(width: 15, height: 15)
                            .matchedGeometryEffect(id: "4", in: animation)
                            .frame(width: 54, height: 54)
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
        .transition(.scale)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                zoom.toggle()
            }
        }
    }
}
