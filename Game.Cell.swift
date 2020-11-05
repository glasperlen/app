import SwiftUI
import Magister

extension Game {
    struct Cell: View {
        @Binding var session: Session
        @State private var flash: Color?
        let point: Magister.Board.Point
        
        var body: some View {
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
                        .stroke(session.match.board[point]!.player.color, style: .init(lineWidth: 1))
                        .padding(5)
                }
                if flash != nil {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(flash!)
                        .padding(5)
                }
                if session.match.board[point] != nil {
                    Bead(bead: session.match.board[point]!.bead)
                        .frame(width: 60, height: 60)
                }
            }
            .onChange(of: session.match.board[point]?.player) {
                guard let color = $0?.color else { return }
                
                withAnimation(.easeInOut(duration: 0.4)) {
                    flash = color
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        flash = nil
                    }
                }
            }
        }
    }
}
