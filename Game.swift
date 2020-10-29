import SwiftUI

struct Game: View {
    @Binding var session: Session
    @State private var new = false
    
    var body: some View {
        VStack {
            Header(session: $session)
            Board()
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
