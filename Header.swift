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
                    .font(.title)
                    .frame(width: 50, height: 45)
            }
            .contentShape(Rectangle())
            Spacer()
            Image(systemName: "person.fill")
            ZStack {
                session.match.map {
                    Score(inverse: true, score: .init($0[.first]))
                        .fill(Color("Opponent"))
                        .animation(.easeInOut(duration: 0.5))
                        .frame(height: 6)
                        .opacity(session.match?.cells.isEmpty == false ? 1 : 0)
                }
                session.match.map {
                    Score(inverse: false, score: .init($0[.second]))
                        .fill(Color("User"))
                        .animation(.easeInOut(duration: 0.5))
                        .frame(height: 6)
                        .opacity(session.match?.cells.isEmpty == false ? 1 : 0)
                }
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 3, height: 6)
            }
            .frame(width: 80)
            session.match?.robot.map {
                Text(verbatim: $0.name)
                    .font(Font.footnote.bold())
                    .padding(.trailing)
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
