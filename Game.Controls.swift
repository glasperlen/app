import SwiftUI

extension Game {
    struct Controls: View {
        @Binding var session: Session
        @State private var menu = false
        @State private var inventory = false
        @State private var alert = false
        
        var body: some View {
            HStack {
                Spacer()
                Control.Circle(image: "bag") {
                    inventory = true
                }
                .sheet(isPresented: $inventory) {
                    Inventory(session: $session)
                }
                Control.Circle(image: "plus") {
                    if session.beads.filter(\.selected).count != 5 {
                        alert = true
                    } else {
                        session.new.send()
                    }
                }
                .alert(isPresented: $alert) {
                    Alert(title: .init("Need 5 beads selected to start a game"),
                          message: .init("Select them on your inventory"),
                          primaryButton: .default(.init("Inventory")) { inventory = true },
                          secondaryButton: .cancel())
                }
                Control.Circle(image: "line.horizontal.3") {
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
