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
                        session.match.map { match in
                            VStack {
                                Text("Choose\n1 bead")
                                    .multilineTextAlignment(.center)
                                    .font(Font.title.bold())
                                    .padding(.bottom)
                                VStack {
                                    HStack {
                                        Item(selected: $selected, bead: match[winner.negative].beads[0])
                                        Item(selected: $selected, bead: match[winner.negative].beads[1])
                                    }
                                    HStack {
                                        Item(selected: $selected, bead: match[winner.negative].beads[2])
                                        Item(selected: $selected, bead: match[winner.negative].beads[3])
                                        Item(selected: $selected, bead: match[winner.negative].beads[4])
                                    }
                                }
                                .padding(.vertical)
                                Control.Capsule(text: "Done", background: .primary, foreground: .black) {
                                    guard let bead = selected else { return }
                                    withAnimation(.easeInOut(duration: 0.35)) {
                                        session.match!.prize(bead)
                                        UIApplication.shared.next(session.match!)
                                    }
                                }
                                .padding(.vertical)
                                .opacity(selected == nil ? 0 : 1)
                                .allowsHitTesting(selected != nil)
                            }
                            .offset(y: -50)
                        }
                    } else {
                        if session.multiplayer {
                            session.match.map {
                                Text("\($0[winner].name)\nTakes 1 bead")
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
                                    if match[winner].id.isEmpty {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            session.match?.prize(match[winner.negative].beads.randomElement()!)
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
