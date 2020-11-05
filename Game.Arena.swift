import SwiftUI

extension Game {
    struct Arena: View {
        @Binding var session: Session
        
        var body: some View {
            VStack {
                Match(session: $session)
                Spacer()
                Controls(session: $session)
            }
        }
    }
}
