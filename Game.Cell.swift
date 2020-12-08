import SwiftUI
import Magister

extension Game {
    struct Cell: View {
        @Binding var session: Session
        @Binding var positions: Positions
        let point: Point
        let frame: CGRect
        @State private var flash: Color?
        
        var body: some View {
            Place(state: state)
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
        
        private var state: Place.State {
            positions.drop == point ? .hover :
                session.match?[point]?.player == nil ? .empty :
                flash == nil ? .taken(session.match![point]!.bead, session[session.match![point]!.player] ? .init("User") : .init("Opponent")) :
                .flash(session.match![point]!.bead, flash!)
        }
    }
}
