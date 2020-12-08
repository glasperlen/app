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
                        Bead(bead: result.bead)
                    }
                    .padding(.top, 50)
                    Text("This bead will be")
                        .padding(.top)
                    Text("removed from your inventory.")
                    Spacer()
                    Control.Capsule(text: "Done", background: .primary, foreground: .black) {
                        UIApplication.shared.end()
                        withAnimation(.easeInOut(duration: 1)) {
                            session.match = nil
                            Defaults.game = nil
                        }
                    }
                    .padding(.bottom)
                }
            }
            .onAppear {
                if session[result.winner] {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        session.beads.append(.init(selected: false, item: result.bead))
                        UIApplication.shared.victory()
                        UIApplication.shared.remove()
                        session.match = nil
                        Defaults.game = nil
                    }
                } else {
                    session.beads.removeAll { $0.item == result.bead }
                    visible = true
                }
            }
        }
    }
}
