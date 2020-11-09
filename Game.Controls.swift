import SwiftUI

extension Game {
    struct Controls: View {
        @Binding var session: Session
        @State private var inventory = false
        
        var body: some View {
            HStack {
                Spacer()
                Control.Circle(image: "star") {
                    
                }
                Control.Circle(image: "plus") {
                    session.new.send()
                }
                Control.Circle(image: "bag") {
                    inventory = true
                }
                .sheet(isPresented: $inventory) {
                    Inventory(session: $session)
                }
                Spacer()
            }
        }
    }
}
