import SwiftUI
import Magister

extension Game {
    struct New: View {
        @Binding var session: Session
        @State private var me = true
        @State private var opponent = ""
        
        var body: some View {
            VStack {
                Spacer()
                Text(verbatim: opponent)
                    .font(Font.title.bold())
                    .padding()
                if me {
                    Image(systemName: "arrowtriangle.down.fill")
                        .font(.title)
                        .foregroundColor(.user)
                        .padding(.vertical)
                } else {
                    Image(systemName: "arrowtriangle.up.fill")
                        .font(.title)
                        .foregroundColor(.opponent)
                        .padding(.vertical)
                }
                Text(verbatim: UIApplication.name.value)
                    .font(Font.title.bold())
                    .padding()
                Spacer()
            }.onAppear {
                var match = session.match!
                match.join(.user(Defaults.id, "", session.beads.filter { $0.selected }.map(\.item)))
                match.join(.robot(match[.first]))
                opponent = match[.second].name
                
                var rolls = 7
                if case let .play(wait) = match.state {
                    if wait.player == .first {
                        rolls = 6
                    }
                }
                
                (0 ..< rolls).forEach { roll in
                    DispatchQueue.main.asyncAfter(deadline: .now() + (0.2 * .init(roll))) {
                        session.play(.Basso)
                        
                        withAnimation(.easeInOut(duration: 0.2)) {
                            me.toggle()
                        }
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                    session.match = match
                }
            }
        }
        
        private func roll() {
            session.play(.Basso)
            
            withAnimation(.easeInOut(duration: 0.2)) {
                me.toggle()
            }
        }
    }
}
