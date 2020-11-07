import SwiftUI
import Magister

extension Game {
    struct Board: View {
        @Binding var session: Session
        
        var body: some View {
            GeometryReader { geo in
                Group {
                    VStack {
                        ForEach(0 ..< 3) { y in
                            HStack {
                                ForEach(0 ..< 3) { x in
                                    let point = Magister.Board.Point(x, y)
                                    if session.carry != nil && session.match.board[point] == nil {
                                        Button {
                                            let carry = session.carry!
                                            session.carry = nil
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                withAnimation(.easeInOut(duration: 1)) {
                                                    session.match.play(carry, point)
                                                }
                                            }
                                        } label: {
                                            Cell(session: $session, point: point)
                                        }
                                    } else {
                                        Cell(session: $session, point: point)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .frame(height: geo.size.width)
            }
        }
    }

}
