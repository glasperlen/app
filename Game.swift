import SwiftUI

struct Game: View {
    var body: some View {
        VStack {
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
