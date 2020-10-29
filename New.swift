import SwiftUI

struct New: View {
    @Binding var session: Session
    @Environment(\.presentationMode) var visible
    
    var body: some View {
        VStack {
            Text("New game")
                .font(.headline)
                .foregroundColor(.primary)
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
        }.padding(.vertical)
    }
}
