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
                    Text("This bead will be\nremoved from your inventory")
                        .font(Font.title2.bold())
                        .padding()
                    Control.Capsule(text: "Done", background: .primary, foreground: .black) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            visible = false
                        }
                        UIApplication.shared.end()
                        withAnimation(.easeInOut(duration: 1.5)) {
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
                    session.beads.removeAll { $0.item == result.bead && $0.selected }
                    visible = true
                }
            }
        }
    }
}
