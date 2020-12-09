import SwiftUI

extension Game {
    struct Matching: View {
        @Binding var session: Session
        
        var body: some View {
            VStack {
                Spacer()
                Text("Waiting for player two...")
                    .bold()
                    .foregroundColor(.secondary)
                Control.Capsule(text: "Cancel", background: .secondary, foreground: .black) {
                    session.match!.cancel()
                }
                .padding(.vertical, 100)
                Refresh(session: $session)
                Spacer()
            }
        }
    }
}
