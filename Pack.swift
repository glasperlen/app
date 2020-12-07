import SwiftUI

struct Pack: View {
    let beads: [Session.Bead]
    @State private var detail = false
    
    var body: some View {
        Button {
            detail = true
        } label: {
            VStack {
                Image(systemName: "bag.fill")
                    .font(.title)
                    .foregroundColor(.primary)
                HStack {
                    ForEach(beads, id: \.self) {
                        Bead.Base(color: $0.item.color.color)
                            .frame(width: 20, height: 20)
                    }
                }
            }
        }
        .contentShape(Rectangle())
        .fullScreenCover(isPresented: $detail) {
            Detail(beads: beads)
        }
    }
}
