import SwiftUI

extension Game.Deck {
    struct Bead: View {
        @Binding var session: Session
        @State var item: Item
        
        var body: some View {
            ZStack {
                Circle()
                    .fill(Color.background)
                    .modifier(Neumorphic())
                    .frame(width: 80, height: 80)
                Circle()
                    .fill(item.bead.color.color)
                    .frame(width: 16, height: 16)
                Text(verbatim: "\(item.bead[.top])")
                    .foregroundColor(.primary)
                    .font(.footnote)
                    .offset(y: -20)
                Text(verbatim: "\(item.bead[.bottom])")
                    .foregroundColor(.primary)
                    .font(.footnote)
                    .offset(y: 20)
                Text(verbatim: "\(item.bead[.left])")
                    .foregroundColor(.primary)
                    .font(.footnote)
                    .offset(x: -20)
                Text(verbatim: "\(item.bead[.right])")
                    .foregroundColor(.primary)
                    .font(.footnote)
                    .offset(x: 20)
            }
            .offset(item.offset)
            .gesture(
                DragGesture(coordinateSpace: .global)
                    .onChanged { gesture in
                        session.gameplay?.drop = session.gameplay?.cells.filter { session.match.board[$0.0] == nil }.first { $0.1.contains(gesture.location) }?.0
                        item.offset = gesture.translation
                    }
                    .onEnded { _ in
                        if let drop = session.gameplay?.drop {
                            session.match.play(item.index, drop)
                        } else {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                item.offset = .zero
                            }
                        }
                        session.gameplay?.drop = nil
                    }
            )
        }
    }
}
