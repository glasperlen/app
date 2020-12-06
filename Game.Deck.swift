import SwiftUI
import Magister

extension Game {
    struct Deck: View {
        @Binding var session: Session
        @Binding var positions: Positions
        let wait: Match.Wait
        @State private var offset = [Session.Bead : CGSize]()
        
        var body: some View {
            Timer(session: $session, wait: wait)
                .padding(.vertical)
            HStack {
                Spacer()
                ForEach(session.beads.filter(\.selected).filter { session.match?[$0.item] == false }, id: \.self) { bead in
                    Bead(bead: bead.item)
                        .frame(width: 50, height: 50)
                        .scaleEffect(0.9)
                        .offset(offset[bead] ?? .zero)
                        .gesture(
                            DragGesture(coordinateSpace: .global)
                                .onChanged { gesture in
                                    positions.drop = positions.cells
                                        .filter { session.match?[$0.0]?.player == nil }
                                        .first { $0.1.contains(gesture.location) }?.0
                                    offset[bead] = gesture.translation
                                }
                                .onEnded { _ in
                                    if let drop = positions.drop {
                                        withAnimation(.easeInOut(duration: 1)) {
                                            session.match![drop] = bead.item
                                            UIApplication.shared.next(session.match!)
                                        }
                                    } else {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            offset[bead] = nil
                                        }
                                    }
                                    positions.drop = nil
                                }
                        )
                }
                Spacer()
            }
            .padding(.vertical)
        }
    }
}
