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
            Finish.PrizeRobot(session: $session)
            Finish.Remove(session: $session)
        }
        .onReceive(session.new) {
            withAnimation(.easeInOut(duration: 0.5)) {
                loading = true
            }
        }
    }
}
