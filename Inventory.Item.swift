import SwiftUI

extension Inventory {
    struct Item: View {
        @Binding var session: Session
        let bead: Session.Bead
        
        var body: some View {
            Button {
                guard bead.selected || session.beads.filter(\.selected).count < 5 else { return }
                session.beads[session.beads.firstIndex(of: bead)!].selected.toggle()
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.primary)
                        .frame(width: 62, height: 62)
                        .opacity(bead.selected ? 1 : 0)
                    Bead(bead: bead.item)
                        .frame(width: 56, height: 56)
                        .opacity(bead.selected ? 1 : 0.5)
                }
            }
            .contentShape(Rectangle())
            .padding()
        }
    }
}
