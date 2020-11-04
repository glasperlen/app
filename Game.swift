import SwiftUI

struct Game: View {
    @Binding var session: Session
    @State private var new = false
    @State private var menu = false
    
    var body: some View {
        VStack {
            if session.match == .off {
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
                if session.match == .off {
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
                } else {
                    Control.Circle(image: "line.horizontal.3.circle.fill") {
                        menu = true
                    }
                    .sheet(isPresented: $menu) {
                        Menu(session: $session)
                    }
                    Control.Circle(image: "plus.circle.fill") {
                        new = true
                    }
                }
                Spacer()
            }
        }
    }
}
