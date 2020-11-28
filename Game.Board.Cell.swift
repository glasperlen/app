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
                if session.match?[point] == nil {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color("Background"))
                        .modifier(Neumorphic())
                        .padding(5)
                } else {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(session.match![point]!.state.color(session), style: .init(lineWidth: 1))
                        .padding(5)
                    Bead(bead: session.match![point]!.bead)
                        .frame(width: 60, height: 60)
                }
                if flash != nil {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(flash!)
                        .padding(5)
                }
                if positions.drop == point {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color("User"), style: .init(lineWidth: 1))
                        .padding(5)
                }
            }
            .onChange(of: session.match?[point]?.state) { [old = session.match?[point]?.state] in
                guard let color = $0?.color(session) else { return }
                
                if old == nil {
                    session.play(.Tink)
                } else {
                    session.impact()
                }
                
                withAnimation(.easeInOut(duration: 0.4)) {
                    flash = color
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    if old != nil {
                        session.play(.Pop)
                    }
                    
                    withAnimation(.easeInOut(duration: 0.4)) {
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
