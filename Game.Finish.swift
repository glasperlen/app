import SwiftUI
import Magister

extension Game {
    struct Finish: View {
        @Binding var session: Session
        @State private var finished: Magister.Match.Result?
        
        var body: some View {
            ZStack {
                if finished != nil {
                    Color.background.opacity(0.9)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        HStack {
                            Text("Game Over")
                                .font(.body)
                            Spacer()
                        }
                        HStack {
                            Text({
                                switch finished! {
                                case .draw: return "Draw!"
                                case .win: return "You win!"
                                case .loose: return "You loose!"
                                }
                            } () as LocalizedStringKey)
                                .font(Font.largeTitle.bold())
                            Spacer()
                        }
                        Spacer()
                        Control.Capsule(text: "Done", background: .primary, foreground: .background) {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                session.match = .off
                                finished = nil
                            }
                        }
                    }
                    .padding(40)
                }
            }
            .onReceive(session.match.finish) { result in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    session.gameplay = nil
                    withAnimation(.easeInOut(duration: 0.5)) {
                        finished = result
                    }
                }
            }
        }
    }
}
