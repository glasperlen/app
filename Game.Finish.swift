import SwiftUI
import Magister

extension Game {
    struct Finish: View {
        @Binding var session: Session
        @State private var finished: Match.Result?
        
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
                                session.match = nil
                                finished = nil
                            }
                        }
                    }
                    .padding(40)
                }
            }
            .onChange(of: session.match?.result) { result in
                guard let result = result else { return }
                switch result {
                case .win:
                    Defaults.victories += 1
                    UIApplication.shared.victories(Defaults.victories)
                case .loose: break
                case .draw: break
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    session.play(result == .win ? .Hero : .Bottle)
                    
                    withAnimation(.easeInOut(duration: 0.5)) {
                        finished = result
                    }
                }
            }
        }
    }
}
