import SwiftUI
import Magister

extension Header {
    struct Score: View {
        @Binding var session: Session
        let player: Player.Mode
        
        var body: some View {
            HStack {
                if player != .user {
                    Text(verbatim: session.match[.oponent].name)
                        .lineLimit(1)
                        .font(.caption2)
                        .padding(.leading)
                }
                Text(NSNumber(value: session.match[player].score), formatter: NumberFormatter())
                    .fixedSize(horizontal: true, vertical: false)
                    .font(Font.body.bold())
                    .padding()
            }
            .frame(height: 30)
            .foregroundColor(.black)
            .background(RoundedRectangle(cornerRadius: 15)
                            .fill(player.color.opacity(session.match.turn == player ? 1 : 0.3)))
        }
    }
}
