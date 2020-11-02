import SwiftUI
import Magister

extension Header {
    struct Score<P>: View where P : View {
        @Binding var session: Session
        let player: P
        let edge: Edge.Set
        let order: Player.Order
        
        var body: some View {
            ZStack {
                HStack {
                    if edge == .leading {
                        player
                            .padding(.leading)
                    }
                    Text(NSNumber(value: session.board[order].score), formatter: NumberFormatter())
                        .padding(.horizontal)
                        .font(.footnote)
                    if edge == .trailing {
                        player
                            .padding(.trailing)
                    }
                }
                .frame(height: 30)
                .foregroundColor(.background)
            }
            .background(RoundedRectangle(cornerRadius: 15)
                            .fill(Color.primary))
            .opacity(session.match!.turn == order ? 1 : 0.3)
            .padding(.horizontal)
        }
    }
}
