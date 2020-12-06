import SwiftUI
import Magister

extension Game {
    struct Deck: View {
        @Binding var session: Session
        @Binding var positions: Positions
        let wait: Match.Wait
        @State private var offset = [Session.Bead : CGSize]()
        
        var body: some View {
            VStack {
                Spacer()
                Timer(session: $session, wait: wait)
                    .padding(.vertical)
                HStack {
                    Spacer()
                    ForEach(session.beads.filter(\.selected).filter { session.match?[$0.item] == false }, id: \.self) { bead in
                        Bead(bead: bead.item)
                            .offset(offset[bead] ?? .zero)
                            .gesture(
                                DragGesture(coordinateSpace: .global)
                                    .onChanged { gesture in
                                        positions.drop = positions.cells
                                            .filter { session.match?[$0.0] == nil }
                                            .first { $0.1.contains(gesture.location) }?.0
                                        offset[bead] = gesture.translation
                                    }
                                    .onEnded { _ in
                                        if let drop = positions.drop {
                                            session.match![drop] = bead.item
                                            UIApplication.shared.next(session.match!)
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
                .padding(.bottom, UIDevice.current.userInterfaceIdiom == .pad ? 150 : 40)
            }
        }
    }
}
