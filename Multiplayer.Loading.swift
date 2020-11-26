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
                .onReceive(GKLocalPlayer.local.publisher(for: \.isAuthenticated).debounce(for: .seconds(1), scheduler: DispatchQueue.main)) { _ in
                    load()
                }
                .onReceive(UIApplication.synch) {
                    load()
                }
                .onChange(of: Defaults.id) {
                    print("new id \($0)")
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
        
        private func load() {
            guard GKLocalPlayer.local.isAuthenticated, session.multiplayer == nil, let id = Defaults.id else { return }
            GKTurnBasedMatch.load(withID: id) {
                error = $1?.localizedDescription
                session.multiplayer = $0
                session.multiplayer?.refresh {
                    session.match = $0
                }
            }
        }
    }
}
