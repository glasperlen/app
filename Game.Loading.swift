import SwiftUI
import Magister

extension Game {
    struct Loading: View {
        @Binding var session: Session
        @Binding var loading: Bool
        @State private var me = true
        @State private var name = ""
        
        var body: some View {
            VStack {
                Text(verbatim: name)
                    .font(.headline)
                    .padding()
                if me {
                    Image(systemName: "arrowtriangle.down.fill")
                        .font(.title)
                        .foregroundColor(.user)
                } else {
                    Image(systemName: "arrowtriangle.up.fill")
                        .font(.title)
                        .foregroundColor(.oponent)
                }
                Image(systemName: "person.fill")
                    .font(.largeTitle)
                    .padding()
            }
            .onAppear {
                let match = Magister.Match.robot(session.inventory.deck)
                name = match[.oponent].name
            }
        }
    }
}
