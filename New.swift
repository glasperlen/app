import SwiftUI
import Magister

struct New: View {
    @Binding var session: Session
    @Environment(\.presentationMode) private var visible
    
    var body: some View {
        VStack {
            Text("New game")
                .padding(.top, 40)
                .font(Font.title.bold())
                .foregroundColor(.primary)
            Spacer()
            HStack {
                Spacer()
                Control.Capsule(text: "Start", background: .primary, foreground: .background) {
                    session.newMatch()
                    visible.wrappedValue.dismiss()
                }
                Spacer()
            }
            Spacer()
            Button {
                visible.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.oponent)
                    .frame(width: 60, height: 60)
            }
            .contentShape(Rectangle())
            .padding(.bottom)
        }
        .modifier(Background())
    }
}
