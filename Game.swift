import SwiftUI

struct Game: View {
    @Binding var session: Session
    @State private var positions = Positions()
    @State private var loading = false
    
    var body: some View {
        ZStack {
            if session.match == nil {
                VStack {
                    Title(session: $session)
                    Spacer()
                    Controls(session: $session)
                }
            } else {
                VStack {
                    Header(session: $session)
                    Board(session: $session, positions: $positions)
                }
            }
            if session.match?.state == .second {
                Deck(session: $session, positions: $positions)
            }
            if loading {
                Loading(session: $session, loading: $loading)
            }
            Turn(session: $session)
            PrizeRobot(session: $session)
            Remove(session: $session)
        }
        .onReceive(session.new) {
            withAnimation(.easeInOut(duration: 0.5)) {
                loading = true
            }
        }
        .onChange(of: session.match?.state) {
            if $0 == .end {
                withAnimation(.easeInOut(duration: 1)) {
                    session.match = nil
                }
            }
        }
    }
}
