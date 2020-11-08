import SwiftUI

struct Game: View {
    @Binding var session: Session
    @State private var loading = false
    
    var body: some View {
        ZStack {
            if session.match == .off {
                VStack {
                    Title(session: $session)
                    Spacer()
                    Controls(session: $session)
                }
            } else {
                VStack {
                    Header(session: $session)
                    Spacer()
                    Board(session: $session)
                }
            }
            if session.match.turn == .user {
                Deck(session: $session)
            }
            if loading {
                Loading(session: $session, loading: $loading)
            }
            Turn(session: $session)
            Finish(session: $session)
        }
        .onReceive(session.new) {
            withAnimation(.easeInOut(duration: 0.5)) {
                loading = true
            }
        }
    }
}
