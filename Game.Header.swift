import SwiftUI
import Magister

extension Game {
    struct Header: View {
        @Binding var session: Session
        let wait: Match.Wait
        @State private var name = ""
        @State private var abandon = false
        
        var body: some View {
            VStack {
                HStack {
                    Text(verbatim: name)
                        .bold()
                        .padding(.horizontal)
                        .opacity(session[wait.player] ? 1 : 0.3)
                    Spacer()
                    session.match.map {
                        Text(verbatim: $0[$0[Defaults.id].negative].name)
                            .bold()
                            .padding(.horizontal)
                            .opacity(session[wait.player.negative] ? 1 : 0.3)
                    }
                }
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.user)
                            .frame(width: 25, height: 25)
                            .opacity(session[wait.player] ? 1 : 0.5)
                        session.match.map {
                            Text(verbatim: "\($0[$0[Defaults.id]])")
                                .font(Font.footnote.bold().monospacedDigit())
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.leading)
                    if session[wait.player] {
                        Button {
                            abandon = true
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.opponent)
                                .font(Font.title2.bold())
                                .frame(width: 40, height: 25)
                        }
                        .contentShape(Rectangle())
                    }
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.opponent)
                            .frame(width: 25, height: 25)
                            .opacity(session[wait.player.negative] ? 1 : 0.5)
                        session.match.map {
                            Text(verbatim: "\($0[$0[Defaults.id].negative])")
                                .font(Font.footnote.bold().monospacedDigit())
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.trailing)
                }
                if session.multiplayer {
                    Timer(session: $session, wait: wait)
                }
            }
            .padding()
            .alert(isPresented: $abandon) {
                .init(title: .init("Quit game?"), message: .init("You will loose"), primaryButton: .destructive(.init("Quit")) {
                    session.play(.Bottle)
                    session.match!.quit(Defaults.id)
                    UIApplication.shared.next(session.match!)
                }, secondaryButton: .cancel(.init("Cancel")))
            }
            .onReceive(UIApplication.name) {
                name = $0
            }
        }
    }
}
