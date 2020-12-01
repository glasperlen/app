import SwiftUI
import Magister

extension Game {
    struct Timer: View {
        @Binding var session: Session
        let wait: Match.Wait
        
        var body: some View {
            if session.match?[wait.player.negative].id.isEmpty == false {
                VStack {
                    if !session[wait.player] {
                        Text("Waiting")
                            .font(.caption2)
                    }
                    Text(wait.timeout, style: .relative)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}
