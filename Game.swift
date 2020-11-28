import SwiftUI

struct Game: View {
    @Binding var session: Session
    @State private var positions = Positions()
    @AppStorage(Defaults.Key.id.rawValue) private var id: String?
    
    var body: some View {
        ZStack {
            if id != nil && session.multiplayer == nil {
                Loading(session: $session)
            } else if id != nil && session.match?.state == .matching {
                Matching(session: $session)
            } else {
                if session.match == nil {
                    VStack {
                        Title(session: $session)
                        Spacer()
                        Controls(session: $session)
                    }
                } else {
                    VStack {
                        Header(session: $session)
                        Spacer()
                    }
                    Board(session: $session, positions: $positions)
                        .padding(.top, 30)
                }
                if session.play {
                    Deck(session: $session, positions: $positions)
                }
                First(session: $session)
                Second(session: $session)
                PrizeRobot(session: $session)
                Remove(session: $session)
                New(session: $session)
            }
        }
        .onChange(of: session.match?.state) {
            if $0 == .end {
                withAnimation(.easeInOut(duration: 1)) {
                    session.match = nil
                    Defaults.id = nil
                }
            }
        }
        .onReceive(UIApplication.match) {
            session.multiplayer = $0
        }
        .onReceive(UIApplication.data) {
            session.match = $0
        }
    }
}
