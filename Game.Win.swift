import SwiftUI
import Magister

extension Game {
    struct Win: View {
        @Binding var session: Session
        @State private var selected: Magister.Bead?
        let turn: Match.Turn
        
        var body: some View {
            Card(session: $session, state: .win(turn)) {
                Color("Background")
                    .opacity(0.95)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Game Over")
                        .bold()
                        .padding(.top)
                    HStack {
                        Text("You win!")
                            .font(Font.largeTitle.bold())
                            .padding(.leading)
                            .padding(.top)
                        Spacer()
                    }
                    HStack {
                        Text("Choose your prize")
                            .padding(.leading)
                        Spacer()
                    }
                    ForEach(session.match?[turn.negative].beads ?? []) {
                        Item(selected: $selected, bead: $0)
                    }
                    Spacer()
                    if selected != nil {
                        Control.Capsule(text: "Done", background: .primary, foreground: .init("Background")) {
                            guard let bead = selected else { return }
                            selected = nil
                            session.beads.append(.init(selected: false, item: bead))
                            session.match?.prize(bead)
                            UIApplication.shared.victory()
                        }
                        .padding(.bottom)
                    }
                }
            }
        }
    }
}
