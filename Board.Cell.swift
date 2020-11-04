import SwiftUI

extension Board {
    struct Cell: View {
        @Binding var session: Session
        let x: Int
        let y: Int
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                ZStack {
                    Rectangle()
                        .hidden()
                    if session.match.board[x, y] == nil {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.background)
                            .modifier(Neumorphic())
                            .padding(5)
                    } else {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(session.match.board[x, y]!.player == .user ? Color.user : .oponent, style: .init(lineWidth: 1))
                            .padding(5)
                    }
                    if session.match.board[x, y] != nil {
                        Bead(color: session.match.board[x, y]!.bead.color.color)
                            .frame(width: 50, height: 50)
                    }
                }
            }
        }
    }
}
