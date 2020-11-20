import SwiftUI
import Magister

extension Game {
    struct Finish: View {
        @Binding var session: Session
        @State private var finished: Match.Result?
        
        var body: some View {
            ZStack {
                if finished != nil {
                    Color("Background")
                        .opacity(0.95)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Text("Game Over")
                            .bold()
                            .padding(.top)
                        if finished == .win {
                            Win(session: $session, done: done)
                        } else {
                            Loose(session: $session, done: done)
                        }
                    }
                }
            }
            .onChange(of: session.match?.result) { result in
                guard let result = result else { return }
                if result == .win {
                    UIApplication.shared.victory()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    session.play(result == .win ? .Hero : .Bottle)
                    
                    withAnimation(.easeInOut(duration: 0.5)) {
                        finished = result
                    }
                }
            }
        }
        
        private func done() {
            withAnimation(.easeInOut(duration: 0.3)) {
                session.match = nil
                finished = nil
            }
        }
    }
}
