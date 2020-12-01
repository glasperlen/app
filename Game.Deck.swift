import SwiftUI

extension Game {
    struct Deck: View {
        @Binding var session: Session
        @Binding var positions: Positions
        @State private var offset = [UUID : CGSize]()
        
        var body: some View {
            VStack {
                Spacer()
                HStack {
                    ForEach(session.beads.filter(\.selected).filter { session.match?[$0.item] == false }, id: \.item.id) { bead in
                        Spacer()
                        Bead(bead: bead.item)
                            .offset(offset[bead.item.id] ?? .zero)
                            .gesture(
                                DragGesture(coordinateSpace: .global)
                                    .onChanged { gesture in
                                        positions.drop = positions.cells
                                            .filter { session.match?[$0.0] == nil }
                                            .first { $0.1.contains(gesture.location) }?.0
                                        offset[bead.item.id] = gesture.translation
                                    }
                                    .onEnded { _ in
                                        if let drop = positions.drop {
                                            session.match![drop] = bead.item
                                            UIApplication.shared.next(session.match!, completion: nil)
                                        } else {
                                            withAnimation(.easeInOut(duration: 0.3)) {
                                                offset[bead.item.id] = nil
                                            }
                                        }
                                        positions.drop = nil
                                    }
                            )
                    }
                    Spacer()
                }
                .padding(.bottom, 20)
            }
        }
    }
}
