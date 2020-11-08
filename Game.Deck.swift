import SwiftUI

extension Game {
    struct Deck: View {
        @Binding var session: Session
        @State private var offset = Array(repeating: CGSize(), count: 5)
        @State private var items = [Item]()
        
        var body: some View {
            VStack {
                Spacer()
                if items.count > 3 {
                    HStack {
                        Spacer()
                        ForEach(3 ..< items.count, id: \.self, content: item)
                        Spacer()
                    }
                }
                HStack {
                    Spacer()
                    ForEach(0 ..< min(items.count, 3), id: \.self, content: item)
                    Spacer()
                }
            }
            .onChange(of: session.match[.user]) { _ in
                update()
            }
            .onAppear(perform: update)
        }
        
        private func update() {
            items = (0 ..< 5).compactMap {
                guard session.match[.user][$0].state == .waiting else { return nil }
                return .init(item: session.match[.user][$0], index: $0)
            }
        }
        
        private func item(_ index: Int) -> some View {
            ZStack {
                Circle()
                    .fill(Color.background)
                    .modifier(Neumorphic())
                    .frame(width: 70, height: 70)
                Bead(bead: session.match[.user][index].bead)
                    .frame(width: 42, height: 42)
            }
            .offset(offset[index])
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        self.offset[index] = gesture.translation
                    }

                    .onEnded { _ in
                        self.offset[index] = .zero
                    }
            )
        }
    }
}
