import SwiftUI

extension Game {
    struct Cancel: View {
        @Binding var session: Session
        
        var body: some View {
            VStack {
                Spacer()
                Text("Game was cancelled")
                Control.Capsule(text: "Continue", background: .primary, foreground: .black) {
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
