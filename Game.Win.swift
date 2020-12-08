import SwiftUI
import Magister

extension Game {
    struct Win: View {
        @Binding var session: Session
        @State private var selected: Magister.Bead?
        let wait: Match.Wait
        @State private var scale = CGFloat(1)
        
        var body: some View {
            ZStack {
                session.match.map { match in
                    Board {
                        Place(state: .taken(match[$0]!, session[match[$0]!.player] ? .user : .opponent))
                    }
                    .scaleEffect(scale)
                }
                if false {
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
                                        .padding()
                                }
                                Timer(session: $session, wait: wait)
                                    .padding(.vertical)
                                Refresh(session: $session)
                                    .padding(.vertical)
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
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        scale = 0.5
                    }
                }
            }
        }
    }
}
