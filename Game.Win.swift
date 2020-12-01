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
                        HStack {
                            Text("You win!")
                                .font(Font.largeTitle.bold())
                                .padding(.leading)
                                .padding(.top)
                            Spacer()
                        }
                        Prize(session: $session, wait: wait, beads: session.match?[wait.player.negative].beads ?? [])
                    } else {
                        HStack {
                            Text("You loose!")
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
                        .onAppear {
                            session.match.map { match in
                                if match[wait.player].id.isEmpty {
                                    withAnimation(.easeInOut(duration: 1)) {
                                        session.match?.prize(match[wait.player.negative].beads.randomElement()!)
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}
