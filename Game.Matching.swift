import SwiftUI

extension Game {
    struct Matching: View {
        @Binding var session: Session
        
        var body: some View {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("Waiting for player two...")
                    .foregroundColor(.secondary)
                Control.Capsule(text: "Cancel", background: .secondary, foreground: .black) {
                    session.match!.cancel()
                }
                .padding(.vertical)
                Spacer()
            }
        }
    }
}
