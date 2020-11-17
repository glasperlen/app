import SwiftUI

struct Pack: View {
    let beads: [Session.Bead]
    @State private var detail = false
    
    var body: some View {
        Button {
            detail = true
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 120, height: 50)
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color.white.opacity(0.2), style: .init(lineWidth: 1))
                    .frame(width: 120, height: 48)
                HStack {
                    ForEach(beads, id: \.item.id) {
                        Bead.Base(color: $0.item.color.color)
                            .frame(width: 15)
                    }
                }
                .scaleEffect(0.5)
            }
            .contentShape(Rectangle())
        }
        .sheet(isPresented: $detail) {
            Detail(beads: beads)
        }
    }
}
