import SwiftUI
import Magister

extension Onboard {
    struct Third: View {
        @Binding var session: Session
        @Binding var beads: [Magister.Bead]
        @Binding var tab: Int
        
        var body: some View {
            Card {
                HStack {
                    Text("All set!")
                        .font(.footnote)
                    Spacer()
                }
                HStack {
                    Text("You can join matches now!")
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding(.vertical)
                Spacer()
                Control.Capsule(text: "Start", background: .primary, foreground: .init(.systemBackground)) {
                    withAnimation(.easeInOut(duration: 1)) {
                        session.inventory.deck = beads.map(\.id)
                        session.inventory.beads = .init(beads)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
