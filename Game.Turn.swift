import SwiftUI
import Magister

extension Game {
    struct Turn: View {
        @Binding var session: Session
        @State private var turn: Player.Mode?
        
        var body: some View {
            ZStack {
                if turn != nil {
                    Color.background.opacity(0.8)
                        .edgesIgnoringSafeArea(.all)
                    if turn == .user {
                        Text("Your turn")
                            .transition(.slide)
                            .font(Font.title.bold())
                    } else {
                        HStack {
                            Text(verbatim: session.match[.oponent].name)
                                .font(.headline)
                            Text("'s Turn")
                                .font(.headline)
                        }
                        .transition(.slide)
                    }
                }
            }
            .onChange(of: session.match.turn) { new in
                guard new != .none else { return }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        turn = new
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        turn = nil
                    }
                }
                
                if new == .oponent {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeInOut(duration: 1)) {
                            session.match.robot()
                        }
                    }
                }
            }
        }
    }
}
