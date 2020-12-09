import SwiftUI
import Magister

extension Game {
    struct Ending: View {
        @Binding var session: Session
        let state: Match.State
        let winner: Match.Turn
        let wait: Match.Wait
        @State private var selected: Magister.Bead?
        @State private var scale = CGFloat(1)
        @State private var opacity = Double(1)
        @State private var show = false
        @State private var next = false
        
        var body: some View {
            VStack {
                if !show {
                    Spacer()
                }
                ZStack {
                    session.match.map { match in
                        Board {
                            Place(state: match[$0]?.bead == nil ? .empty : .taken(match[$0]!, session[match[$0]!.player] ? .user : .opponent))
                        }
                        .opacity(opacity)
                        .scaleEffect(scale)
                    }
                    if show {
                        Text(message)
                            .multilineTextAlignment(.center)
                            .font(Font.largeTitle.bold())
                            .transition(.slide)
                    }
                }
                if next {
                    if session[winner] {
                        Prize(session: $session, wait: wait, beads: session.match?[wait.player.negative].beads ?? [])
                            .offset(y: -50)
                    } else {
                        if session.multiplayer {
                            session.match.map {
                                Text("\($0[wait.player].name)\nwill take 1 bead")
                                    .multilineTextAlignment(.center)
                                    .font(Font.title.bold())
                                    .padding()
                            }
                            Timer(session: $session, wait: wait)
                                .padding(.vertical)
                            Refresh(session: $session)
                                .padding(.top)
                        } else {
                            Control.Capsule(text: "Continue", background: .primary, foreground: .black) {
                                session.match.map { match in
                                    if match[wait.player].id.isEmpty {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            session.match?.prize(match[wait.player.negative].beads.randomElement()!)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
            .onAppear {
                session.play(.Endgame)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        opacity = 0.2
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        scale = 0.3
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        show = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
                    withAnimation(.easeInOut(duration: 0.7)) {
                        next = true
                    }
                }
            }
        }
        
        private var message: LocalizedStringKey {
            if case .win = state {
                return session[winner] ? "WIN" : "LOOSE"
            } else {
                return session[winner] ? .init(session.match![winner.negative].name + "\nTIMED OUT") : "TIME OUT"
            }
        }
    }
}
