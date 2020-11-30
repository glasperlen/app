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
                    withAnimation(Animation.easeInOut(duration: 0.3).delay(6)) {
                        visible = true
                    }
                }
                .padding()
                .opacity(visible ? 1 : 0)
                .allowsHitTesting(visible)
            }
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 0.3).delay(6)) {
                    visible = true
                }
            }
        }
    }
}
