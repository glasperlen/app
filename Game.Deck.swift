import SwiftUI

extension Game {
    struct Deck: View {
        @Binding var session: Session
        @State private var offset = [UUID : CGSize]()
        
        var body: some View {
            VStack {
                Spacer()
                HStack {
                    ForEach(session.beads.filter(\.selected).filter { session.match?.played($0.item) == false }, id: \.item.id) { bead in
                        Spacer()
                        Bead(bead: bead.item)
                            .offset(offset[bead.item.id] ?? .zero)
                            .gesture(
                                DragGesture(coordinateSpace: .global)
                                    .onChanged { gesture in
                                        session.match?.drop = session.match?.positions
                                            .filter { session.match?[$0.0] == nil }
                                            .first { $0.1.contains(gesture.location) }?.0
                                        offset[bead.item.id] = gesture.translation
                                    }
                                    .onEnded { _ in
                                        if let drop = session.match?.drop {
                                            session.match?.play(bead.item, drop)
                                        } else {
                                            withAnimation(.easeInOut(duration: 0.3)) {
                                                offset[bead.item.id] = nil
                                            }
                                        }
                                        session.match?.drop = nil
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
