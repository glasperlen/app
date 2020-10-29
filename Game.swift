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
                Control.Circle(image: "star.fill", color: .blue) {
                    
                }
                Control.Circle(image: "plus", color: .orange) {
                    
                }
                Control.Circle(image: "chart.bar.fill", color: .blue) {
                    
                }
                Spacer()
            }
        }
    }
}
