import SwiftUI
import Magister

extension Game {
    struct Cell: View {
        @Binding var session: Session
        let point: Magister.Board.Point
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                ZStack {
                    Rectangle()
                        .hidden()
                    if session.match.board[point] == nil {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.background)
                            .modifier(Neumorphic())
                            .padding(5)
                    } else {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(session.match.board[point]!.player == .user ? Color.user : .oponent, style: .init(lineWidth: 1))
                            .padding(5)
                    }
                    if session.match.board[point] != nil {
                        Bead(bead: session.match.board[point]!.bead)
                            .frame(width: 50, height: 50)
                    }
                }
            }
        }
    }
}
