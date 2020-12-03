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
                    ForEach(beads, id: \.item.id) {
                        Bead.Base(color: $0.item.color.color)
                            .frame(width: 30, height: 20)
                    }
                }
                .scaleEffect(0.3)
            }
        }
        .contentShape(Rectangle())
        .sheet(isPresented: $detail) {
            Detail(beads: beads)
        }
    }
}
