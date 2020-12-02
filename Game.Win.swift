import SwiftUI
import Magister

extension Game {
    struct Win: View {
        @Binding var session: Session
        @State private var selected: Magister.Bead?
        let wait: Match.Wait
        
        var body: some View {
            Card(session: $session, state: .win(wait)) {
                Color("Background")
                    .opacity(0.95)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Game Over")
                        .bold()
                        .padding(.top)
                    if session[wait.player] {
                        Text("You win!")
                            .font(Font.largeTitle.bold())
                            .padding(.horizontal)
                            .padding(.top)
                        Prize(session: $session, wait: wait, beads: session.match?[wait.player.negative].beads ?? [])
                    } else {
                        Text("You loose!")
                            .font(Font.largeTitle.bold())
                            .padding(.horizontal)
                            .padding(.top)
                        if session.multiplayer {
                            session.match.map {
                                Text("\($0[wait.player].name) is choosing a prize")
                                    .padding(.horizontal)
                            }
                        } else {
                            Spacer()
                            Control.Capsule(text: "Continue", background: .primary, foreground: .black) {
                                session.match.map { match in
                                    if match[wait.player].id.isEmpty {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            session.match?.prize(match[wait.player.negative].beads.randomElement()!)
                                        }
                                    }
                                }
                            }
                            .padding(.vertical)
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}
