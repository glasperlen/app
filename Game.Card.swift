import SwiftUI
import Magister

extension Game {
    struct Card<Content>: View where Content : View {
        @Binding var session: Session
        let state: Match.State
        let content: Content
        @State private var visible = false
        
        @inlinable public init(session: Binding<Session>, state: Match.State, @ViewBuilder content: () -> Content) {
            _session = session
            self.state = state
            self.content = content()
        }
        
        var body: some View {
            ZStack {
                if visible {
                    content
                }
            }
            .onChange(of: session.match?.state) { _ in
                update()
            }
            .onAppear(perform: update)
        }
        
        private func update() {
            withAnimation(.easeInOut(duration: 1)) {
                visible = session.match?.state == state
            }
        }
    }
}
