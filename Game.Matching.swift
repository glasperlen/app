import SwiftUI

extension Game {
    struct Matching: View {
        @Binding var session: Session
        
        var body: some View {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("Waiting for second player...")
                    .foregroundColor(.secondary)
                Control.Capsule(text: "Cancel", background: .secondary, foreground: .black) {
                    session.match?.cancel()
                    UIApplication.shared.quit()
                    Defaults.game = nil
                    session.match = nil
                }
                .padding(.vertical)
                Spacer()
            }
        }
    }
}
