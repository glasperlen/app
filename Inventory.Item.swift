import SwiftUI

extension Inventory {
    struct Item: View {
        @Binding var session: Session
        let bead: Session.Bead
        @State private var full = false
        
        var body: some View {
            ZStack {
                if bead.selected {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.user.opacity(0.15))
                        .frame(width: 84, height: 84)
                        .padding(2)
                } else if full {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.opponent.opacity(0.2))
                        .frame(width: 84, height: 84)
                        .padding(2)
                }
                RoundedRectangle(cornerRadius: 12)
                    .stroke(full ? Color.opponent : bead.selected ? .user : .init(white: 0.15), style: .init(lineWidth: 3))
                    .frame(width: 84, height: 84)
                    .padding(2)
                Bead(bead: bead.item)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                guard bead.selected || session.beads.filter(\.selected).count < 5 else {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        full = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            full = false
                        }
                    }
                    return
                }
                withAnimation(.easeInOut(duration: 0.35)) {
                    session.beads[session.beads.firstIndex(of: bead)!].selected.toggle()
                }
            }
        }
    }
}
