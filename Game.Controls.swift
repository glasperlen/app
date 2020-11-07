import SwiftUI

extension Game {
    struct Controls: View {
        @Binding var session: Session
        @State private var menu = false
        
        var body: some View {
            HStack {
                Spacer()
                Control.Circle(image: "star.fill") {
                    
                }
                Control.Circle(image: "plus.circle.fill") {
                    session.new.send()
                }
                Control.Circle(image: "line.horizontal.3.circle.fill") {
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
