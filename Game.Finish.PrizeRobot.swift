import SwiftUI
import Magister

extension Game.Finish {
    struct PrizeRobot: View {
        @Binding var session: Session
        @State private var selected: Magister.Bead?
        
        var body: some View {
            Card {
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
                        Item(selected: $selected, bead: $0)
                    }
                }
                Spacer()
                if selected != nil {
                    Control.Capsule(text: "Done", background: .primary, foreground: .init("Background")) {
//                        guard let selected = self.selected else { return }
//                        self.selected = nil
//                        session.beads.append(.init(selected: false, item: selected))
//                        done()
                    }
                    .padding(.bottom)
                }
            }
        }
    }
}
