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
                RoundedRectangle(cornerRadius: 15)
                    .fill(order == .first ? Color.blue : .pink )
                HStack {
                    if edge == .trailing {
                        player
                            .foregroundColor(.white)
                            .padding(.horizontal)
                        Spacer()
                    }
                    Text(NSNumber(value: session.board[order].score), formatter: NumberFormatter())
                        .padding(.horizontal)
                        .font(.footnote)
                    if edge == .leading {
                        Spacer()
                        player
                            .foregroundColor(.white)
                            .padding(.horizontal)
                    }
                }
            }
        }
    }
}
