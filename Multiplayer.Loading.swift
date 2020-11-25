import SwiftUI
import GameKit

extension Multiplayer {
    struct Loading: View {
        @Binding var session: Session
        @State private var error: String?
        
        var body: some View {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    guard session.multiplayer == nil, let id = Defaults.id else { return }
                    GKTurnBasedMatch.load(withID: id) {
                        session.multiplayer = $0
                        error = $1?.localizedDescription
                    }
                }
            if error == nil {
                Text("Loading match...")
                    .foregroundColor(.secondary)
            } else {
                Text(verbatim: error!)
                    .foregroundColor(.secondary)
            }
        }
    }
}
