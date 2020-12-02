import SwiftUI
import Magister

extension Game {
    struct Timeout: View {
        @Binding var session: Session
        @State private var selected: Magister.Bead?
        let wait: Match.Wait
        
        var body: some View {
            Card(session: $session, state: .timeout(wait)) {
                Color("Background")
                    .opacity(0.95)
                    .edgesIgnoringSafeArea(.all)
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
                                .padding(.horizontal)
                        }
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
}
