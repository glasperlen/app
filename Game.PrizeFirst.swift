import SwiftUI
import Magister

extension Game {
    struct PrizeFirst: View {
        @Binding var session: Session
        
        var body: some View {
            Card(session: $session, state: .prizeFirst) {
                Prize(session: $session, beads: [])
            }
        }
    }
}
