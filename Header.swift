import SwiftUI

struct Header: View {
    @Binding var session: Session
    
    var body: some View {
        ZStack {
            if session.match != nil {
                if session.match!.turn == session.match!.local {
                    user
                    oponent
                } else {
                    oponent
                    user
                }
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
    
    private var user: some View {
        HStack {
            Score(session: $session, player:
                    Image(systemName: "person.fill"),
                  edge: .leading, order: session.match!.local)
            Spacer()
        }
    }
    
    private var oponent: some View {
        HStack {
            Spacer()
            Score(session: $session, player:
                    Text(verbatim: "Dimi")
                    .font(.caption2),
                  edge: .trailing, order: session.match!.local == .first ? .second : .first)
        }
    }
}
