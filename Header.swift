import SwiftUI
import Magister

struct Header: View {
    @Binding var session: Session
    let turn: Match.Turn
    @State private var abandon = false
    
    var body: some View {
        VStack {
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
                .allowsHitTesting(session[turn])
                .opacity(session[turn] ? 1 : 0)
                Spacer()
                Image(systemName: "person.fill")
                    .opacity(session[turn] ? 1 : 0.3)
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
                        .opacity(session[turn.negative] ? 1 : 0.3)
                }
            }
            Spacer()
        }
        .padding(.horizontal)
        .alert(isPresented: $abandon) {
            .init(title: .init("Quit game?"), message: .init("You will loose"), primaryButton: .destructive(.init("Quit")) {
                session.play(.Bottle)
                session.match!.quit(Defaults.id)
                UIApplication.shared.next(session.match!)
            }, secondaryButton: .cancel(.init("Cancel")))
        }
    }
}
