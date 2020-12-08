import SwiftUI
import Magister

extension Game {
    struct Play: View {
        @Binding var session: Session
        @State private var visible = false
        @State private var player: Match.Turn?
        
        var body: some View {
            ZStack {
                if visible {
                    Color.background
                        .opacity(0.9)
                        .edgesIgnoringSafeArea(.all)
                    session.match.map { match in
                        player.map {
                            Text(verbatim: session[$0] ? UIApplication.name.value : match[$0].name)
                                .font(Font.largeTitle.bold())
                                .padding()
                                .transition(.slide)
                        }
                    }
                }
            }
            .onChange(of: session.match?.state) { _ in
                turn()
            }
            .onAppear(perform: turn)
        }
        
        private func turn() {
            if case let .play(wait) = session.match?.state {
                if wait.player != player {
                    player = wait.player
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            visible = true
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            visible = false
                        }
                    }
                    
                    if !session.multiplayer {
                        session.match.map { match in
                            if match[wait.player].id.isEmpty {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    withAnimation(.easeInOut(duration: 1)) {
                                        session.match?[wait.player].play(match).map {
                                            session.match?[$0.point] = $0.item?.bead
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                player = nil
            }
        }
    }
}
