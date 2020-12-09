import SwiftUI
import Magister

extension Game {
    struct Prize: View {
        @Binding var session: Session
        let wait: Match.Wait
        let beads: [Magister.Bead]
        @State private var selected: Magister.Bead?
        
        var body: some View {
            Text("Choose\n1 bead")
                .multilineTextAlignment(.center)
                .font(Font.title.bold())
                .padding(.bottom)
            VStack {
                HStack {
                    Item(selected: $selected, bead: beads[0])
                    Item(selected: $selected, bead: beads[1])
                }
                HStack {
                    Item(selected: $selected, bead: beads[2])
                    Item(selected: $selected, bead: beads[3])
                    Item(selected: $selected, bead: beads[4])
                }
            }
            .padding(.vertical)
            Control.Capsule(text: "Done", background: .primary, foreground: .black) {
                guard let bead = selected else { return }
                session.match!.prize(bead)
                UIApplication.shared.next(session.match!)
            }
            .padding(.vertical)
            .opacity(selected == nil ? 0 : 1)
            .allowsHitTesting(selected != nil)
        }
    }
}
