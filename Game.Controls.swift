import SwiftUI

extension Game {
    struct Controls: View {
        @Binding var session: Session
        @State private var menu = false
        @State private var deck = false
        
        var body: some View {
            HStack {
                Spacer()
                if session.match == .off {
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
                } else if session.match.turn == .user {
                    
                    Control.Circle(image: "plus.circle.fill") {
                        deck = true
                    }
                    .sheet(isPresented: $deck) {
                        Deck(session: $session)
                    }
                }
                Spacer()
            }
        }
    }
}
