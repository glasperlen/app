import SwiftUI
import Magister

extension Game {
    struct Play: View {
        @Binding var session: Session
        @State private var visible = false
        let turn: Match.Turn
        
        var body: some View {
            Card(session: $session, state: .play(turn)) {
                ZStack {
                    if visible {
                        Color("Background")
                            .opacity(0.95)
                            .edgesIgnoringSafeArea(.all)
                        session.match.map {
                            Text(session[turn] ? "Your turn" : "\($0[turn].name)'s turn")
                                .padding()
                                .font(Font.title.bold())
                                .transition(.slide)
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            visible = true
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            visible = false
                        }
                    }
                    
                    session.match.map { match in
                        if match[turn].id.isEmpty {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.easeInOut(duration: 1)) {
                                    session.match?[turn].play(match).map {
                                        session.match?[$0.point] = $0.bead
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
