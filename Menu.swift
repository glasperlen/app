import SwiftUI

struct Menu: View {
    @Binding var session: Session
    @State private var abandon = false
    @Environment(\.presentationMode) private var visible
    
    var body: some View {
        VStack {
            HStack {
                Text("Menu")
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                Control.Capsule(text: "Abandon game", background: .oponent, foreground: .black) {
                    abandon = true
                }
                .actionSheet(isPresented: $abandon) {
                    ActionSheet(title: .init("Abandon game?"), message: .init("Your oponent will get 1 of your beads"), buttons: [
                                    .cancel(.init("Cancel")),
                                    .destructive(.init("Abandon")) {
                                        session.match = .off
                                        visible.wrappedValue.dismiss()
                                    }])
                }
                Spacer()
            }
            Button {
                visible.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.oponent)
                    .frame(width: 60, height: 60)
            }
            .contentShape(Rectangle())
            .padding()
        }
        .modifier(Background())
    }
}
