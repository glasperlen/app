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
                        HStack {
                            Text("You timed out!")
                                .font(Font.largeTitle.bold())
                                .padding(.leading)
                                .padding(.top)
                            Spacer()
                        }
                        HStack {
                            session.match.map {
                                Text("\($0[wait.player].name) is choosing a prize")
                                    .padding(.horizontal)
                            }
                            Spacer()
                        }
                        Spacer()
                    } else {
                        HStack {
                            session.match.map {
                                Text("\($0[wait.player].name) timed out")
                                    .font(Font.largeTitle.bold())
                                    .padding(.leading)
                                    .padding(.top)
                            }
                            Spacer()
                        }
                        Prize(session: $session, wait: wait, beads: session.match?[wait.player].beads ?? [])
                    }
                }
            }
        }
    }
}
