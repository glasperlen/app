import SwiftUI
import Magister

extension Game {
    struct Timer: View {
        @Binding var session: Session
        let wait: Match.Wait
        @State private var date = ""
        private let timer = SwiftUI.Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
        var body: some View {
            if session.match?[wait.player.negative].id.isEmpty == false {
                VStack {
                    if !session[wait.player] {
                        Text("Waiting")
                            .font(.caption2)
                    }
                    Text(verbatim: date)
                        .font(Font.footnote.monospacedDigit())
                        .foregroundColor(.secondary)
                }.onReceive(timer) {
                    let formatter = DateComponentsFormatter()
                    formatter.allowedUnits = [.second]
                    formatter.unitsStyle = .short
                    date = formatter.string(from: $0, to: wait.timeout)!
                }
            }
        }
    }
}
