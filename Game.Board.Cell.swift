import SwiftUI
import Magister

extension Game.Board {
    struct Cell: View {
        @Binding var session: Session
        @Binding var positions: Positions
        @State private var flash: Color?
        let point: Point
        let frame: CGRect
        
        var body: some View {
            ZStack {
                Rectangle()
                    .hidden()
                if positions.drop == point {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color("Background"))
                        .shadow(color: Color("User"), radius: 7)
                        .padding(5)
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color("User"), style: .init(lineWidth: 1))
                        .padding(5)
                } else if session.match?[point]?.player == nil {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color("Background"))
                        .modifier(Neumorphic())
                        .padding(5)
                } else {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color("Background"))
                        .shadow(color: session[session.match![point]!.player] ? Color("User") : .init("Opponent"), radius: 7)
                        .padding(5)
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(session[session.match![point]!.player] ? Color("User") : .init("Opponent"), style: .init(lineWidth: 1))
                        .padding(5)
                    Bead(bead: session.match![point]!.bead)
                }
                if flash != nil {
                    RoundedRectangle(cornerRadius: 11)
                        .fill(flash!)
                        .padding(9)
                }
            }
            .onChange(of: session.match?[point]?.player) { [old = session.match?[point]?.player] in
                guard let player = $0 else { return }
                if old == nil {
                    session.play(.Tink)
                } else {
                    session.impact()
                }
                
                withAnimation(.easeInOut(duration: 0.5)) {
                    flash = session[player] ? Color("User") : .init("Opponent")
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if old != nil {
                        session.play(.Pop)
                    }
                    
                    withAnimation(.easeInOut(duration: 0.5)) {
                        flash = nil
                    }
                }
            }
            .onAppear {
                positions[point] = frame
            }
        }
    }
}
