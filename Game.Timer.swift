import SwiftUI
import Magister

extension Game {
    struct Timer: View {
        @Binding var session: Session
        let wait: Match.Wait
        @State private var date = ""
        @State private var formatter = DateComponentsFormatter()
        private let timer = SwiftUI.Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
        var body: some View {
            VStack {
                Text(verbatim: date)
                    .font(Font.title.bold().monospacedDigit())
                    .foregroundColor(.secondary)
            }
            .onAppear {
                formatter.allowedUnits = [.second]
                formatter.unitsStyle = .positional
                formatter.zeroFormattingBehavior = .pad
            }
            .onReceive(timer) {
                if $0 < wait.timeout {
                    date = formatter.string(from: $0, to: wait.timeout)!
                } else {
                    timer.upstream.connect().cancel()
                    date = ""
                    UIApplication.shared.load()
                }
            }
        }
    }
}
