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
                        ForEach(items.dropFirst(3), id: \.bead.id) {
                            Bead(session: $session, item: $0)
                        }
                        Spacer()
                    }
                }
                HStack {
                    Spacer()
                    ForEach(items.prefix(3), id: \.bead.id) {
                        Bead(session: $session, item: $0)
                    }
                    Spacer()
                }
            }
            .onChange(of: session.match[.user]) { _ in
                update()
            }
            .onAppear(perform: update)
        }
        
        private func update() {
            guard session.match != .off else { return }
            items = (0 ..< 5).compactMap {
                guard session.match[.user][$0].state == .waiting else { return nil }
                return .init(index: $0, bead: session.match[.user][$0].bead)
            }
        }
    }
}
