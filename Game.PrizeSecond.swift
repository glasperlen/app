import SwiftUI
import Magister

extension Game {
    struct PrizeSecond: View {
        @Binding var session: Session
        
        var body: some View {
            Card(session: $session, state: .prizeSecond) {
                Prize(session: $session, beads: [])
            }
        }
    }
}
