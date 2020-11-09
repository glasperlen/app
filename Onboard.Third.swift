import SwiftUI

extension Onboard {
    struct Third: View {
        @Binding var session: Session
        @Binding var tab: Int
        @Environment(\.presentationMode) private var visible
        
        var body: some View {
            Card {
                HStack {
                    Text("All set!")
                        .font(.footnote)
                    Spacer()
                }
                HStack {
                    Text("You can join matches now!")
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding(.vertical)
                Spacer()
                Control.Capsule(text: "Start", background: .primary, foreground: .background) {
                    visible.wrappedValue.dismiss()
                }
            }
        }
    }
}
