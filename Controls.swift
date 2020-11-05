import SwiftUI

struct Controls: View {
    @Binding var session: Session
    @State private var new = false
    @State private var menu = false
    
    var body: some View {
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
