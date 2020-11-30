import SwiftUI
import Magister

extension Game {
    struct New: View {
        @Binding var session: Session
        @State private var me = true
        @State private var name = ""
        @State private var visible = false
        
        var body: some View {
            Card(session: $session, state: .new) {
                Color("Background")
                    .opacity(0.95)
                    .edgesIgnoringSafeArea(.all)
                    .onAppear {
                        var match = session.match!
                        match.join(.user(Defaults.id, "", session.beads.filter { $0.selected }.map(\.item)))
                        match.join(.robot(match[.first]))
                        name = match[.second].name
                        
                        let rolls = match.state == .play(.first) ? 6 : 7
                        
                        (0 ..< rolls).forEach { roll in
                            DispatchQueue.main.asyncAfter(deadline: .now() + (0.2 * .init(roll))) {
                                if roll == 0 {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        visible = true
                                    }
                                }
                                session.play(.Basso)
                                
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    me.toggle()
                                }
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                visible = false
                            }
                            session.match = match
                        }
                    }
                if visible {
                    VStack {
                        HStack {
                            Text("Start")
                                .font(Font.largeTitle.bold())
                                .padding(40)
                            Spacer()
                        }
                        Spacer()
                    }
                    VStack {
                        Spacer()
                        Text(verbatim: name)
                            .font(Font.title.bold())
                            .padding()
                        if me {
                            Image(systemName: "arrowtriangle.down.fill")
                                .font(.title)
                                .foregroundColor(.init("User"))
                                .padding()
                        } else {
                            Image(systemName: "arrowtriangle.up.fill")
                                .font(.title)
                                .foregroundColor(.init("Opponent"))
                                .padding()
                        }
                        Image(systemName: "person.fill")
                            .font(.largeTitle)
                            .padding()
                        Spacer()
                    }
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
