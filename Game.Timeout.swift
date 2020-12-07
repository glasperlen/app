import SwiftUI
import Magister

extension Game {
    struct Timeout: View {
        @Binding var session: Session
        @State private var selected: Magister.Bead?
        let wait: Match.Wait
        
        var body: some View {
            VStack {
                Text("Game Over")
                    .bold()
                    .padding(.top)
                if session[wait.player] {
                    Text("You timed out!")
                        .font(Font.largeTitle.bold())
                        .padding(.horizontal)
                        .padding(.top)
                    session.match.map {
                        Text("\($0[wait.player.negative].name) is choosing a prize")
                            .padding()
                    }
                    Timer(session: $session, wait: wait)
                        .padding(.vertical)
                    Refresh(session: $session)
                        .padding(.vertical)
                    Spacer()
                } else {
                    session.match.map {
                        Text("\($0[wait.player].name) timed out")
                            .font(Font.largeTitle.bold())
                            .padding(.horizontal)
                            .padding(.top)
                    }
                    Prize(session: $session, wait: wait, beads: session.match?[wait.player].beads ?? [])
                }
            }
        }
    }
}
