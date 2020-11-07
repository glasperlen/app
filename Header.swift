import SwiftUI

struct Header: View {
    @Binding var session: Session
    @State private var abandon = false
    
    var body: some View {
        HStack {
            Button {
                abandon = true
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.oponent)
                    .font(.title)
                    .frame(width: 50, height: 45)
            }
            .contentShape(Rectangle())
            .padding(.leading)
            Spacer()
            Score(session: $session, player: .oponent)
                .padding(.leading)
            Score(session: $session, player: .user)
                .padding(.trailing)
        }
        .actionSheet(isPresented: $abandon) {
            ActionSheet(title: .init("Abandon game?"), message: .init("Your oponent will get 1 of your beads"), buttons: [
                            .cancel(.init("Cancel")),
                            .destructive(.init("Abandon")) {
                                session.match = .off
                            }])
        }
    }
}
