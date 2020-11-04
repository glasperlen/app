import SwiftUI

struct Game: View {
    @Binding var session: Session
    @State private var new = false
    
    var body: some View {
        VStack {
            if session.match == nil {
                VStack {
                    HStack {
                        Text("The")
                            .font(.body)
                        Spacer()
                    }
                    HStack {
                        Text("Glass")
                            .font(Font.largeTitle.bold())
                        Spacer()
                    }
                    HStack {
                        Text("Bead")
                            .font(Font.largeTitle.bold())
                        Spacer()
                    }
                    HStack {
                        Text("Game")
                            .font(Font.largeTitle.bold())
                        Spacer()
                    }
                }
                .padding(40)
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
                Control.Circle(image: "plus.app.fill") {
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
