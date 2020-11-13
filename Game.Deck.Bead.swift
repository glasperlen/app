import SwiftUI
import Magister

extension Game.Deck {
    struct Bead: View {
        @Binding var session: Session
        @State var item: Magister.Bead
        @State private var offset = CGSize()
        
        var body: some View {
            ZStack {
                Circle()
                    .fill(Color.background)
                    .modifier(Neumorphic())
                    .frame(width: 80, height: 80)
                Circle()
                    .fill(item.color.color)
                    .frame(width: 16, height: 16)
                Text(verbatim: "\(item[.top])")
                    .foregroundColor(.primary)
                    .font(.footnote)
                    .offset(y: -20)
                Text(verbatim: "\(item[.bottom])")
                    .foregroundColor(.primary)
                    .font(.footnote)
                    .offset(y: 20)
                Text(verbatim: "\(item[.left])")
                    .foregroundColor(.primary)
                    .font(.footnote)
                    .offset(x: -20)
                Text(verbatim: "\(item[.right])")
                    .foregroundColor(.primary)
                    .font(.footnote)
                    .offset(x: 20)
            }
            .offset(offset)
            .gesture(
                DragGesture(coordinateSpace: .global)
                    .onChanged { gesture in
                        session.match?.drop = session.match?.positions.filter { session.match?[$0.0] == nil }.first { $0.1.contains(gesture.location) }?.0
                        offset = gesture.translation
                    }
                    .onEnded { _ in
                        if let drop = session.match?.drop {
                            session.match?.play(item, drop)
                        } else {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                offset = .zero
                            }
                        }
                        session.match?.drop = nil
                    }
            )
        }
    }
}
