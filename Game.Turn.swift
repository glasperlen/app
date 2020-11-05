import SwiftUI
import Magister

extension Game {
    struct Turn: View {
        @Binding var session: Session
        @State private var turn: Player.Mode?
        
        var body: some View {
            ZStack {
                if turn != nil {
                    Color.background.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Text("Next turn")
                            .font(.headline)
                            .padding()
                        if turn == .user {
                            Text("Your turn")
                                .font(Font.title.bold())
                                .padding()
                        } else {
                            Text(verbatim: session.match[.oponent].name)
                                .font(.title)
                                .padding()
                        }
                    }
                    .transition(.slide)
                }
            }
            .onChange(of: session.match.turn) { new in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        turn = new
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        turn = nil
                    }
                }
            }
        }
    }
}
