import SwiftUI
import Magister

extension Game {
    struct Timer: View {
        @Binding var session: Session
        let wait: Match.Wait
        
        var body: some View {
            if session.match?[wait.player.negative].id.isEmpty == false {
                VStack {
                    HStack {
                        Text("Times out in")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .padding(.leading)
                        Spacer()
                    }
                    HStack {
                        Text(wait.timeout, style: .relative)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .padding(.leading)
                        Spacer()
                    }
                }
            }
        }
    }
}
