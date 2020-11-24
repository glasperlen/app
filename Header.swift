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
                    .foregroundColor(.init("Opponent"))
                    .font(.title3)
                    .frame(width: 50, height: 40)
            }
            .contentShape(Rectangle())
            Spacer()
            Image(systemName: "person.fill")
                .opacity(session.match?.state == .second ? 1 : 0.3)
            session.match.map {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color("User"))
                    .frame(width: 10, height: $0[.second] > $0[.first] ? 20 : 10)
                    .animation(.easeInOut(duration: 0.5))
            }
            session.match.map {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color("Opponent"))
                    .frame(width: 10, height: $0[.first] > $0[.second] ? 20 : 10)
                    .animation(.easeInOut(duration: 0.5))
            }
            session.match?.robot.map {
                Text(verbatim: $0.name)
                    .bold()
                    .padding(.trailing)
                    .opacity(session.match?.state == .first ? 1 : 0.3)
            }
        }
        .padding(.horizontal)
        .actionSheet(isPresented: $abandon) {
            .init(title: .init("Abandon game?"), message: .init("Your opponent will get 1 of your beads"), buttons: [
                    .cancel(.init("Cancel")),
                    .destructive(.init("Abandon")) {
                        session.play(.Bottle)
                        withAnimation(.easeInOut(duration: 0.5)) {
                            session.match = nil
                        }
                    }])
        }
    }
}
