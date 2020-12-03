import SwiftUI

extension Onboard {
    struct Third: View {
        @Binding var session: Session
        @Binding var tab: Int
        @State private var tutorial = false
        @Environment(\.presentationMode) private var visible
        
        var body: some View {
            Card {
                HStack {
                    Text("All set!")
                        .font(.footnote)
                    Spacer()
                }
                HStack {
                    Text("You can start playing!")
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding(.vertical)
                Spacer()
                Button {
                    tutorial = true
                } label: {
                    Text("Tutorial")
                        .foregroundColor(.primary)
                        .font(Font.footnote.bold())
                        .frame(minWidth: 100, minHeight: 50)
                }
                .sheet(isPresented: $tutorial) {
                    Tutorial()
                }
                Control.Capsule(text: "Start", background: .primary, foreground: .black) {
                    visible.wrappedValue.dismiss()
                }
            }
        }
    }
}
