import SwiftUI
import Magister

extension Game {
    struct PrizeRobot: View {
        @Binding var session: Session
        @State private var selected: Magister.Bead?
        @State private var visible = false
        
        var body: some View {
            Card(session: $session, state: .prizeRobot) {
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
                session.match?.robot.map {
                    ForEach($0.beads) {
                        Prize(selected: $selected, bead: $0)
                    }
                }
                Spacer()
                if selected != nil {
                    Control.Capsule(text: "Done", background: .primary, foreground: .init("Background")) {
                        guard let bead = selected else { return }
                        selected = nil
                        session.beads.append(.init(selected: false, item: bead))
                        session.match?.prize = bead
                    }
                    .padding(.bottom)
                }
            }
            .onChange(of: session.match?.state) {
                if $0 == .prizeRobot {
                    visible = true
                } else {
                    visible = false
                }
            }
        }
    }
}
