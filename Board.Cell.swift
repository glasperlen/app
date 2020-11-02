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
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.background)
                        .modifier(Neumorphic())
                        .frame(width: 90, height: 90)
                    if session.board[x, y] != nil {
                        Bead(color: session.board[x, y]!.bead.color.color)
                            .frame(width: 50, height: 50)
                    }
                }
            }
        }
    }
}
