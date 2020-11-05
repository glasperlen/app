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
                VStack {
                    HStack {
                        Spacer()
                        Text("Who plays first?")
                            .font(.headline)
                            .padding(.top, 50)
                        Spacer()
                    }
                    Spacer()
                }
                VStack {
                    Text(verbatim: name)
                        .font(.headline)
                        .foregroundColor(.oponent)
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
                        .foregroundColor(.user)
                        .padding()
                }
            }
            .onAppear {
                let match = Magister.Match.robot(session.inventory.deck)
                name = match[.oponent].name
                let rolls = match.turn == .user ? 8 : 9
            
                (0 ..< rolls).forEach {
                    DispatchQueue.main.asyncAfter(deadline: .now() + (0.2 * .init($0))) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            me.toggle()
                        }
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        loading = false
                        session.match = match
                    }
                }
            }
        }
    }
}
