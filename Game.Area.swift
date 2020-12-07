import SwiftUI
import Magister

extension Game {
    struct Area: View {
        @Binding var session: Session
        let wait: Match.Wait
        @State private var positions = Positions()
        
        var body: some View {
            VStack {
                Header(session: $session, turn: wait.player)
                Spacer()
                Board(session: $session, positions: $positions)
                VStack {
                    Spacer()
                    if session[wait.player] {
                        Deck(session: $session, positions: $positions, wait: wait)
                    }
                }
                .frame(height: 180)
                Spacer()
            }
            if !session[wait.player] {
                Refresh(session: $session, wait: wait)
            }
            Play(session: $session)
        }
    }
}
