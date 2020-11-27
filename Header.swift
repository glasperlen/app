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
                .opacity(session.play ? 1 : 0.3)
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
            Text(verbatim: session.opponent)
                .bold()
                .padding(.trailing)
                .opacity(!session.play ? 1 : 0.3)
        }
        .padding(.horizontal)
        .actionSheet(isPresented: $abandon) {
            .init(title: .init("Quit game?"), message: .init("You will loose"), buttons: [
                    .cancel(.init("Cancel")),
                    .destructive(.init("Quit")) {
                        session.play(.Bottle)
                        if let multiplayer = session.multiplayer {
                            Defaults.id = nil
                            session.match = nil
                            Defaults.match = nil
                        } else {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                session.match?.quitSecond()
                            }
                        }
                    }])
        }
    }
}
