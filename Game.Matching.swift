import SwiftUI
import GameKit

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
                    session.match?.quitFirst()
                    session.match = nil
                    session.multiplayer?.quit()
                    
                    Defaults.id = nil
                    session.multiplayer = nil
                }
                .padding(.bottom)
            }
            .onAppear {
                session.multiplayer?.saveCurrentTurn(withMatch: try! JSONEncoder().encode(session.match!))
            }
        }
    }
}
