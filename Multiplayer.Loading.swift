import SwiftUI
import GameKit
import Magister

extension Multiplayer {
    struct Loading: View {
        @Binding var session: Session
        @State private var error: String?
        
        var body: some View {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        guard session.multiplayer == nil, let id = Defaults.id else { return }
                        GKTurnBasedMatch.load(withID: id) {
                            error = $1?.localizedDescription
                            session.multiplayer = $0
                            session.multiplayer?.loadMatchData {
                                guard $1 == nil else { return }
                                session.match = $0.flatMap {
                                    try? JSONDecoder().decode(Match.self, from: $0)
                                }
                            }
                        }
                    }
                }
            if error == nil {
                Text("Loading match...")
                    .foregroundColor(.secondary)
            } else {
                Text(verbatim: error!)
                    .foregroundColor(.secondary)
                    .padding()
            }
        }
    }
}
