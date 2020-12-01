import SwiftUI

struct Header: View {
    @Binding var session: Session
    @State private var abandon = false
    
    var body: some View {
        HStack {
            session.match.map {
                Button {
                    abandon = true
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.init("Opponent"))
                        .font(.title3)
                        .frame(width: 50, height: 40)
                }
                .contentShape(Rectangle())
                .allowsHitTesting($0.state == .play($0[Defaults.id]))
                .opacity($0.state == .play($0[Defaults.id]) ? 1 : 0)
            }
            Spacer()
            session.match.map {
                Image(systemName: "person.fill")
                    .opacity($0.state == .play($0[Defaults.id]) ? 1 : 0.3)
            }
            session.match.map {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color("User"))
                    .frame(width: 10, height: $0[$0[Defaults.id]] > $0[$0[Defaults.id].negative] ? 20 : 10)
                    .animation(.easeInOut(duration: 0.5))
            }
            session.match.map {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color("Opponent"))
                    .frame(width: 10, height: $0[$0[Defaults.id].negative] > $0[$0[Defaults.id]] ? 20 : 10)
                    .animation(.easeInOut(duration: 0.5))
            }
            session.match.map {
                Text(verbatim: $0[$0[Defaults.id].negative].name)
                    .bold()
                    .padding(.trailing)
                    .opacity($0.state == .play($0[Defaults.id].negative) ? 1 : 0.3)
            }
        }
        .padding(.horizontal)
        .actionSheet(isPresented: $abandon) {
            .init(title: .init("Quit game?"), message: .init("You will loose"), buttons: [
                    .cancel(.init("Cancel")),
                    .destructive(.init("Quit")) {
                        session.play(.Bottle)
                        session.match!.quit(Defaults.id)
                        UIApplication.shared.next(session.match!, completion: nil)
                    }])
        }
    }
}
