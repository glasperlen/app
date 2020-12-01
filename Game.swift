import SwiftUI

struct Game: View {
    @Binding var session: Session
    @State private var positions = Positions()
    @AppStorage(Defaults.Key.game.rawValue) private var game: String?
    
    var body: some View {
        ZStack {
            if session.match == nil {
                if game == nil {
                    VStack {
                        Title(session: $session)
                        Spacer()
                        Controls(session: $session)
                    }
                } else {
                    Loading(session: $session)
                }
            } else if session.match?.state == .cancel {
                Cancel(session: $session)
            } else if session.match?.state == .matching {
                Matching(session: $session)
                Refresh(session: $session)
            } else if case let .end(result) = session.match?.state {
                End(session: $session, result: result)
            } else {
                Board(session: $session, positions: $positions)
                    .padding(.top, 30)
                if case let .play(wait) = session.match?.state {
                    Header(session: $session, turn: wait.player)
                    if session[wait.player] {
                        Deck(session: $session, positions: $positions)
                    } else {
                        Refresh(session: $session)
                    }
                    Play(session: $session, wait: wait)
                }
                if case let .win(wait) = session.match?.state {
                    Win(session: $session, wait: wait)
                    if !session[wait.player] {
                        Refresh(session: $session)
                    }
                }
                if case let .timeout(wait) = session.match?.state {
                    Timeout(session: $session, wait: wait)
                    if session[wait.player] {
                        Refresh(session: $session)
                    }
                }
                New(session: $session)
            }
        }
        .onReceive(UIApplication.match) {
            session.match = $0
        }
    }
}
