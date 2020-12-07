import SwiftUI
import Magister

extension Game {
    struct Refresh: View {
        @Binding var session: Session
        @State private var visible = false
        
        var body: some View {
            Control.Circle(image: "arrow.clockwise") {
                UIApplication.shared.load()
                withAnimation(.easeInOut(duration: 0.3)) {
                    visible = false
                }
                refresh()
            }
            .opacity(visible ? 1 : 0)
            .allowsHitTesting(visible)
            .onAppear(perform: refresh)
        }
        
        private func refresh() {
            withAnimation(Animation.easeInOut(duration: 0.3).delay(5)) {
                visible = true
            }
        }
    }
}
