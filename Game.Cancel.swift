import SwiftUI

extension Game {
    struct Cancel: View {
        @Binding var session: Session
        
        var body: some View {
            Color("Background")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("Game was cancelled")
                    .foregroundColor(.secondary)
                Control.Capsule(text: "Done", background: .primary, foreground: .black) {
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
