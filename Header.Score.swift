import SwiftUI
import Magister

extension Header {
    struct Score: View {
        @Binding var session: Session
        let player: Player.Mode
        
        var body: some View {
            HStack {
                if player == .user {
                    Image(systemName: "person.fill")
                        .padding(.leading)
                }
                Text(NSNumber(value: session.match![player].score), formatter: NumberFormatter())
                    .fixedSize(horizontal: true, vertical: false)
                    .font(Font.body.bold())
                    .padding(.horizontal)
                if player == .oponent {
                    Text(verbatim: session.match![.oponent].name)
                        .font(.caption2)
                        .padding(.trailing)
                }
            }
            .frame(height: 30)
            .foregroundColor(.black)
            .background(RoundedRectangle(cornerRadius: 15)
                            .fill(player == .user ? Color.user : .oponent))
            .opacity(session.match!.turn == player ? 1 : 0.3)
            .padding(.horizontal)
        }
    }
}
