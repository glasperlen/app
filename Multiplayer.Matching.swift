import SwiftUI
import GameKit

extension Multiplayer {
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
                    Defaults.id = nil
                    session.multiplayer = nil
                    
                    session.match?.quitFirst()
                    session.multiplayer?.quit()
                }
                .padding(.bottom)
            }
            .onAppear {
                session.multiplayer?.saveCurrentTurn(withMatch: try! JSONEncoder().encode(session.match!))
            }
        }
    }
}
