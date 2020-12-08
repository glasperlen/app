import SwiftUI

extension Game {
    struct Controls: View {
        @Binding var session: Session
        @Binding var new: Bool
        @State private var menu = false
        @State private var inventory = false
        @State private var alert = false
        
        var body: some View {
            HStack {
                Spacer()
                Control.Circle(image: "circle.grid.2x2.fill") {
                    inventory = true
                }
                .sheet(isPresented: $inventory) {
                    Inventory(session: $session)
                }
                Control.Circle(image: "plus") {
                    if session.beads.filter(\.selected).count == 5 {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            new = true
                        }
                    } else {
                        alert = true
                    }
                }
                .actionSheet(isPresented: $alert) {
                    .init(title: .init("Need 5 beads selected to play"),
                                 message: .init("Select them in your inventory"),
                                 buttons: [
                                     .default(.init("Inventory")) { inventory = true },
                                     .cancel()])
                }
//                .actionSheet(isPresented: $alert) {
//                    if session.beads.filter(\.selected).count == 5 {
//                        return .init(title: .init("New game"),
//                                     buttons: [
//                                        .default(.init("Single")) {
//                                            session.match = .init()
//                                        },
//                                        .default(.init("Multiplayer")) {
//                                            UIApplication.shared.request()
//                                        },
//                                        .cancel()])
//                    } else {
//                        return .init(title: .init("Need 5 beads selected to play"),
//                                     message: .init("Select them in your inventory"),
//                                     buttons: [
//                                         .default(.init("Inventory")) { inventory = true },
//                                         .cancel()])
//                    }
//                }
                Control.Circle(image: "slider.vertical.3") {
                    menu = true
                }
                .sheet(isPresented: $menu) {
                    Menu(session: $session)
                }
                Spacer()
            }
            .padding(.bottom)
        }
    }
}
