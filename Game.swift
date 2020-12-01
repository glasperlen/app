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
            } else if session.match?.state == .matching {
                Matching(session: $session)
                Refresh(session: $session)
            } else if case let .end(bead) = session.match?.state {
                End(session: $session, bead: bead)
            } else if session.match?.state != .cancel {
                VStack {
                    Header(session: $session)
                    Spacer()
                }
                Board(session: $session, positions: $positions)
                    .padding(.top, 30)
                Win(session: $session, turn: .first)
                Win(session: $session, turn: .second)
                if session.match!.state == .play(session.match![Defaults.id]) {
                    Deck(session: $session, positions: $positions)
                } else if session.match!.state == .play(session.match![Defaults.id].negative) {
                    Refresh(session: $session)
                } else if session.match!.state == .win(session.match![Defaults.id].negative) {
                    Refresh(session: $session)
                }
                Play(session: $session, turn: .first)
                Play(session: $session, turn: .second)
                New(session: $session)
            }
        }
        .onReceive(UIApplication.match) {
            session.match = $0
        }
    }
}
