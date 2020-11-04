import SwiftUI

struct Header: View {
    @Binding var session: Session
    
    var body: some View {
        ZStack {
            if session.match.turn == .user {
                user
                oponent
            } else {
                oponent
                user
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    private var user: some View {
        HStack {
            Score(session: $session, player: .user)
            Spacer()
        }
    }
    
    private var oponent: some View {
        HStack {
            Spacer()
            Score(session: $session, player: .oponent)
        }
    }
}
