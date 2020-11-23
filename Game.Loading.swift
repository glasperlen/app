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
                Color("Background")
                    .opacity(0.95)
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
            .onAppear {
                var match = Match()
                match.robot = .init(session.beads.filter { $0.selected }.map(\.item))
                name = match.robot!.name
                let rolls = match.state == .second ? 4 : 5
                
                (0 ..< rolls).forEach {
                    DispatchQueue.main.asyncAfter(deadline: .now() + (0.2 * .init($0))) {
                        
                        session.play(.Basso)
                        
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
