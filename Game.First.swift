import SwiftUI
import Magister

extension Game {
    struct First: View {
        @Binding var session: Session
        @State private var visible = false
        
        var body: some View {
            Card(session: $session, state: .first) {
                ZStack {
                    if visible {
                        Color("Background")
                            .opacity(0.95)
                            .edgesIgnoringSafeArea(.all)
                        if session.me == .first {
                            Text("Your turn")
                                .transition(.slide)
                                .font(Font.title.bold())
                                .transition(.slide)
                        } else {
                            Text("\(session.opponentName)'s turn")
                                .padding()
                                .font(Font.title.bold())
                                .transition(.slide)
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            visible = true
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            visible = false
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation(.easeInOut(duration: 1)) {
                            session.match.map {
                                $0.robot?.play($0).map {
                                    session.match?[$0.point] = $0.bead
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
