import SwiftUI

struct Game: View {
    @Binding var session: Session
    @State private var new = false
    
    var body: some View {
        VStack {
            if session.match == nil {
                Image(systemName: "ant")
                    .fullScreenCover(isPresented: $session.onboard) {
                        Onboard(session: $session)
                            .modifier(Background())
                            .preferredColorScheme(.dark)
                    }
            } else {
                Match(session: $session)
            }
            Spacer()
            HStack {
                Spacer()
                Control.Circle(image: "star.fill") {
                    
                }
                Control.Circle(image: "plus") {
                    new = true
                }
                .sheet(isPresented: $new) {
                    New(session: $session)
                }
                Control.Circle(image: "chart.bar.fill") {
                    
                }
                Spacer()
            }
        }
    }
}
