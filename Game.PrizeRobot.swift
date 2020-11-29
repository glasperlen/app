import SwiftUI
import Magister

extension Game {
    struct PrizeRobot: View {
        @Binding var session: Session
        
        var body: some View {
            Card(session: $session, state: .prizeRobot) {
                Prize(session: $session, beads: session.match?.robot?.beads ?? [])
            }
        }
    }
}
