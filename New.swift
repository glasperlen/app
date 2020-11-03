import SwiftUI
import Magister

struct New: View {
    @Binding var session: Session
    @Environment(\.presentationMode) private var visible
    
    var body: some View {
        VStack {
            Text("New game")
                .padding(.top)
                .font(.headline)
                .foregroundColor(.primary)
            Spacer()
            HStack {
                Spacer()
                Control.Capsule(text: "Start", background: .primary, foreground: .background) {
                    session.match = .robot(session.inventory.deck)
                    visible.wrappedValue.dismiss()

//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                        session.board[0, 0] = session.match!.turn.active(session.inventory[4]!)
//                    }
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//                        session.match?.next()
//                    }
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
//                        session.board[1, 0] = session.match!.turn.active(session.inventory[0]!)
//                    }
//
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
//                        session.match?.next()
//                    }
                }
                Spacer()
            }
            Spacer()
            Button {
                visible.wrappedValue.dismiss()
            } label: {
                Text("Cancel")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .frame(minWidth: 100, minHeight: 50)
            }
            .contentShape(Rectangle())
            .padding(.bottom)
        }
        .modifier(Background())
    }
}
