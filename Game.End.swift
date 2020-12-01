import SwiftUI
import Magister

extension Game {
    struct End: View {
        @Binding var session: Session
        let bead: Magister.Bead
        @State private var visible = false
        
        var body: some View {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Game Over")
                    .bold()
                    .padding(.top)
                if visible {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.secondarySystemBackground))
                            .frame(width: 120, height: 120)
                        Circle()
                            .fill(Color.black.opacity(0.2))
                            .frame(width: 80, height: 80)
                        Bead(bead: bead)
                    }
                    .padding(.top, 50)
                    Text("This bead will be")
                        .padding(.top)
                    Text("removed from your inventory.")
                    Spacer()
                    Control.Capsule(text: "Done", background: .primary, foreground: .init("Background")) {
                        UIApplication.shared.end()
                        done()
                    }
                    .padding(.bottom)
                }
            }.onAppear {
                if session.beads.contains(where: { $0.item == bead }) {
                    session.beads.removeAll { $0.item == bead }
                    visible = true
                } else {
                    done()
                }
            }
        }
        
        private func done() {
            withAnimation(.easeInOut(duration: 1)) {
                session.match = nil
                Defaults.game = nil
            }
        }
    }
}
