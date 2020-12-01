import SwiftUI
import Magister

extension Game {
    struct Refresh: View {
        @Binding var session: Session
        let wait: Match.Wait?
        @State private var visible = false
        
        var body: some View {
            VStack {
                Spacer()
                if wait != nil {
                    Timer(session: $session, wait: wait!)
                        .padding(.bottom)
                }
                Control.Circle(image: "arrow.clockwise") {
                    UIApplication.shared.load()
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
