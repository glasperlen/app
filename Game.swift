import SwiftUI

struct Game: View {
    var body: some View {
        VStack {
            Header()
            Board()
            Spacer()
            HStack {
                Spacer()
                Control.Circle(image: "star.fill", color: .blue) {
                    
                }
                Control.Circle(image: "plus", color: .blue) {
                    
                }
                Control.Circle(image: "chart.bar.fill", color: .blue) {
                    
                }
                Spacer()
            }
        }
    }
}
