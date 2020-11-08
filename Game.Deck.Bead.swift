import SwiftUI

extension Game.Deck {
    struct Bead: View {
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
                DragGesture()
                    .onChanged { gesture in
                        item.offset = gesture.translation
                    }

                    .onEnded { _ in
                        item.offset = .zero
                    }
            )
        }
    }
}
