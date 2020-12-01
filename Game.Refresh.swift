import SwiftUI

extension Game {
    struct Refresh: View {
        @Binding var session: Session
        @State private var visible = false
        
        var body: some View {
            VStack {
                Spacer()
                Control.Circle(image: "arrow.clockwise") {
                    UIApplication.shared.refresh()
                    withAnimation(.easeInOut(duration: 0.3)) {
                        visible = false
                    }
                    refresh()
                }
                .padding()
                .opacity(visible ? 1 : 0)
                .allowsHitTesting(visible)
            }
            .onAppear(perform: refresh)
        }
        
        private func refresh() {
            withAnimation(Animation.easeInOut(duration: 0.3).delay(10)) {
                visible = true
            }
        }
    }
}
