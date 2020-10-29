import SwiftUI

struct Game: View {
    @Binding var session: Session
    
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
                    
                }
                Control.Circle(image: "chart.bar.fill") {
                    
                }
                Spacer()
            }
        }
    }
}
