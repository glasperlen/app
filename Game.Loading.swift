import SwiftUI
import GameKit
import Magister

extension Game {
    struct Loading: View {
        @Binding var session: Session
        
        var body: some View {
            Text("Loading match...")
                .bold()
                .foregroundColor(.secondary)
                .onReceive(GKLocalPlayer.local.publisher(for: \.isAuthenticated).debounce(for: .seconds(1), scheduler: DispatchQueue.main)) { _ in
                    UIApplication.shared.load()
                }
        }
    }
}
