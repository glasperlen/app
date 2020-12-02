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
                Control.Capsule(text: "Tutorial", background: .secondary, foreground: .init("Background")) {
                    tutorial = true
                }
                .sheet(isPresented: $tutorial) {
                    Tutorial()
                }
                Control.Capsule(text: "Start", background: .primary, foreground: .init("Background")) {
                    visible.wrappedValue.dismiss()
                }
            }
        }
    }
}
