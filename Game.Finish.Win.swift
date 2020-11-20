import SwiftUI
import Magister

extension Game.Finish {
    struct Win: View {
        @Binding var session: Session
        let done: () -> Void
        @State private var prize: Magister.Bead?
        
        var body: some View {
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
            ForEach(session.match?.opponent.beads ?? []) {
                Item(prize: $prize, bead: $0)
            }
            Spacer()
            if prize != nil {
                Control.Capsule(text: "Done", background: .primary, foreground: .init("Background")) {
                    guard let prize = self.prize else { return }
                    self.prize = nil
                    session.beads.append(.init(selected: false, item: prize))
                    done()
                }
                .padding(.bottom)
            }
        }
    }
}
