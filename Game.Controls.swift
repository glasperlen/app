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
                    alert = true
                }
                .actionSheet(isPresented: $alert) {
                    if session.beads.filter(\.selected).count == 5 {
                        return .init(title: .init("New game"),
                                     message: .init("Choose your opponent"),
                                     buttons: [
                                        .default(.init("A player from Game Center")) {
                                            UIApplication.shared.requestMatch()
                                        },
                                        .default(.init("Artificial Intelligence")) {
                                            session.match = .init()
                                        },
                                        .cancel()])
                    } else {
                        return .init(title: .init("Need 5 beads selected to start a game"),
                                     message: .init("Select them on your inventory"),
                                     buttons: [
                                         .default(.init("Inventory")) { inventory = true },
                                         .cancel()])
                    }
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
