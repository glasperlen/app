import SwiftUI

extension Game {
    struct Cancel: View {
        @Binding var session: Session
        
        var body: some View {
            VStack {
                Spacer()
                Text("Game Cancelled")
                    .bold()
                Control.Capsule(text: "Continue", background: .primary, foreground: .black) {
                    UIApplication.shared.quit()
                    Defaults.game = nil
                    session.match = nil
                }
                .padding(.vertical, 50)
                Spacer()
            }
        }
    }
}
