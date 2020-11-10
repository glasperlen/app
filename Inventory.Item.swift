import SwiftUI

extension Inventory {
    struct Item: View {
        @Binding var session: Session
        let bead: Session.Bead
        
        var body: some View {
            Button {
                session.beads[session.beads.firstIndex(of: bead)!].selected.toggle()
            } label: {
                ZStack {
                    Circle()
                        .stroke(Color.user, style: .init(lineWidth: 5))
                        .frame(width: 65, height: 65)
                        .opacity(bead.selected ? 1 : 0)
                    Bead(bead: bead.item)
                }
            }
            .contentShape(Rectangle())
            .padding()
        }
    }
}
