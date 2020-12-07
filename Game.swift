import SwiftUI

struct Game: View {
    @Binding var session: Session
    @AppStorage(Defaults.Key.game.rawValue) private var game: String?
    
    var body: some View {
        ZStack {
            switch session.match?.state {
            case nil:
                if game == nil {
                    Title(session: $session)
                } else {
                    Loading(session: $session)
                }
            case .new: New(session: $session)
            case .matching: Matching(session: $session)
            case .cancel: Cancel(session: $session)
            case let .play(wait): Area(session: $session, wait: wait)
            case let .win(wait): Win(session: $session, wait: wait)
            case let .timeout(wait): Timeout(session: $session, wait: wait)
            case let .end(result): End(session: $session, result: result)
            }
        }
        .transition(.opacity)
        .onReceive(UIApplication.match) {
            session.match = $0
        }
    }
}
