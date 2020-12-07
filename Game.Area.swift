import SwiftUI
import Magister

extension Game {
    struct Area: View {
        @Binding var session: Session
        let wait: Match.Wait
        @State private var positions = Positions()
        
        var body: some View {
            ZStack {
                Board(session: $session, positions: $positions)
                VStack {
                    Header(session: $session, wait: wait)
                    Spacer()
                    if session[wait.player] {
                        Deck(session: $session, positions: $positions)
                    } else if session.multiplayer {
                        Refresh(session: $session)
                    }
                    Spacer()
                        .frame(height: 70)
                }
            }
            Play(session: $session)
        }
    }
}
