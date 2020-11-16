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
                        .stroke(Color.primary, style: .init(lineWidth: 3))
                        .frame(width: 55, height: 55)
                        .opacity(bead.selected ? 1 : 0)
                    Bead(bead: bead.item)
                        .opacity(bead.selected ? 1 : 0.4)
                }
            }
            .contentShape(Rectangle())
            .padding()
        }
    }
}
