import SwiftUI

extension Game {
    struct Matching: View {
        @Binding var session: Session
        
        var body: some View {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            Text("Waiting for second player...")
                .foregroundColor(.secondary)
            VStack {
                Spacer()
                Control.Capsule(text: "Cancel", background: .secondary, foreground: .black) {
                    session.match?.cancel()
                }
                .padding(.bottom)
            }
        }
    }
}
