import SwiftUI

struct Header: View {
    @Binding var session: Session
    
    var body: some View {
        ZStack {
            if session.match != nil {
                Score(session: $session, player:
                        Image(systemName: "person.fill"),
                      edge: .leading, order: .first)
                Spacer()
                Score(session: $session, player:
                        Text(verbatim: "Dimi")
                        .font(.caption2),
                      edge: .trailing, order: .second)
            }
        }
        .frame(height: 30)
        .padding(.horizontal)
    }
}
