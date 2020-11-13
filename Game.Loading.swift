import SwiftUI
import Magister

extension Game {
    struct Loading: View {
        @Binding var session: Session
        @Binding var loading: Bool
        @State private var me = true
        @State private var name = ""
        
        var body: some View {
            ZStack {
                Color.background.opacity(0.95)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        Text("First turn")
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
                            .foregroundColor(.user)
                            .padding()
                    } else {
                        Image(systemName: "arrowtriangle.up.fill")
                            .font(.title)
                            .foregroundColor(.oponent)
                            .padding()
                    }
                    Image(systemName: "person.fill")
                        .font(.largeTitle)
                        .padding()
                    Spacer()
                }
            }
            .onAppear {
                let match = Match(session.beads.filter { $0.selected }.map(\.item))
                name = match.oponent.name
                let rolls = match.turn == .user ? 4 : 5
            
                (0 ..< rolls).forEach {
                    DispatchQueue.main.asyncAfter(deadline: .now() + (0.2 * .init($0))) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            me.toggle()
                        }
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        loading = false
                        session.match = match
                    }
                }
            }
        }
    }
}
