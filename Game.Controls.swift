import SwiftUI

extension Game {
    struct Controls: View {
        @Binding var session: Session
        @State private var menu = false
        
        var body: some View {
            HStack {
                Spacer()
                Control.Circle(image: "star") {
                    
                }
                Control.Circle(image: "plus") {
                    session.new.send()
                }
                Control.Circle(image: "bag") {
                    menu = true
                }
                .sheet(isPresented: $menu) {
                    Menu(session: $session)
                }
                Spacer()
            }
        }
    }
}
