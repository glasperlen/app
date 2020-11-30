import SwiftUI
import GameKit
import Magister

extension Game {
    struct Loading: View {
        @Binding var session: Session
        @State private var error: String?
        
        var body: some View {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
                .onReceive(GKLocalPlayer.local.publisher(for: \.isAuthenticated).debounce(for: .seconds(1), scheduler: DispatchQueue.main)) { _ in
                    UIApplication.shared.load()
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
