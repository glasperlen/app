import SwiftUI
import Magister

extension Game {
    struct Turn: View {
        @Binding var session: Session
        @State private var show = false
        
        var body: some View {
            ZStack {
                if show {
                    Color("Background")
                        .opacity(0.8)
                        .edgesIgnoringSafeArea(.all)
                    if session.match?.state == .second {
                        Text("Your turn")
                            .transition(.slide)
                            .font(Font.title.bold())
                    } else {
                        HStack {
                            session.match?.robot.map {
                                Text("\($0.name)'s turn")
                                    .padding()
                                    .font(Font.title.bold())
                            }
                        }
                        .transition(.slide)
                    }
                }
            }
            .onChange(of: session.match?.state) {
                guard let new = $0, new == .first || new == .second else { return }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        show = true
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        show = false
                    }
                }
                
                if new == .first {
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
