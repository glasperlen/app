import SwiftUI

struct Game: View {
    @Binding var session: Session
    @State private var positions = Positions()
    @AppStorage(Defaults.Key.game.rawValue) private var game: String?
    
    var body: some View {
        ZStack {
            if session.match == nil {
                if game == nil {
                    Title(session: $session)
                } else {
                    Loading(session: $session)
                }
            } else if session.match?.state == .matching {
                Matching(session: $session)
                Refresh(session: $session, wait: nil)
            } else if session.match?.state == .new {
                New(session: $session)
            } else if session.match?.state == .cancel {
                Cancel(session: $session)
            } else if case let .play(wait) = session.match?.state {
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
            } else if case let .win(wait) = session.match?.state {
                Win(session: $session, wait: wait)
                if !session[wait.player] {
                    Refresh(session: $session, wait: wait)
                }
            } else if case let .timeout(wait) = session.match?.state {
                Timeout(session: $session, wait: wait)
                if session[wait.player] {
                    Refresh(session: $session, wait: wait)
                }
            } else if case let .end(result) = session.match?.state {
                End(session: $session, result: result)
            }
        }
        .transition(.opacity)
        .onReceive(UIApplication.match) {
            session.match = $0
        }
    }
}
