import SwiftUI
import Magister

extension Game {
    struct End: View {
        @Binding var session: Session
        let result: Match.Result
        @State private var visible = false
        
        var body: some View {
            VStack {
                Text("Game Over")
                    .font(Font.title.bold())
                    .padding(.top, 50)
                if visible {
                    Bead(bead: result.bead)
                        .padding(.top, 40)
                    Text("Will be removed\nfrom your inventory")
                        .multilineTextAlignment(.center)
                        .font(Font.title3.bold())
                        .padding(.horizontal)
                        .padding(.bottom, 40)
                    Control.Capsule(text: "Done", background: .primary, foreground: .black) {
                        session.beads.removeAll { $0.item == result.bead && $0.selected }
                        withAnimation(.easeInOut(duration: 0.5)) {
                            visible = false
                        }
                        UIApplication.shared.end()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            session.match = nil
                            Defaults.game = nil
                        }
                    }
                    .padding(.vertical)
                }
            }
            .onAppear {
                if session[result.winner] {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        session.beads.append(.init(selected: false, item: result.bead))
                        UIApplication.shared.victory()
                        UIApplication.shared.remove()
                        session.match = nil
                        Defaults.game = nil
                    }
                } else {
                    visible = true
                }
            }
        }
    }
}
