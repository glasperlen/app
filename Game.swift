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
            } else if case let .end(bead) = session.match?.state {
                End(session: $session, bead: bead)
            } else if session.match?.state != .cancel {
                VStack {
                    Header(session: $session)
                    Spacer()
                }
                Board(session: $session, positions: $positions)
                    .padding(.top, 30)
                if session.match!.state == .play(session.match![Defaults.id]) {
                    Deck(session: $session, positions: $positions)
                } else if !session.match![session.match![Defaults.id].negative].id.isEmpty {
                    Refresh(session: $session)
                }
                Play(session: $session, turn: .first)
                Play(session: $session, turn: .second)
                Win(session: $session, turn: .first)
                Win(session: $session, turn: .second)
                New(session: $session)
            }
        }
        .onChange(of: session.match?.state) {
            if $0 == .cancel {
                session.match = nil
                UIApplication.shared.quit()
            }
        }
        .onReceive(UIApplication.match) {
            session.match = $0
        }
    }
}
