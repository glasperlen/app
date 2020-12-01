import SwiftUI
import Magister

extension Game {
    struct Play: View {
        @Binding var session: Session
        @State private var visible = false
        let wait: Match.Wait
        
        var body: some View {
            Card(session: $session, state: .play(wait)) {
                ZStack {
                    if visible {
                        Color("Background")
                            .opacity(0.95)
                            .edgesIgnoringSafeArea(.all)
                        session.match.map {
                            Text(session[wait.player] ? "Your turn" : "\($0[wait.player].name)'s turn")
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
                        if match[wait.player].id.isEmpty {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.easeInOut(duration: 1)) {
                                    session.match?[wait.player].play(match).map {
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
