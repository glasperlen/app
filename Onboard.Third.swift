import SwiftUI
import Magister

extension Onboard {
    struct Third: View {
        @Binding var session: Session
        @State private var tutorial = false
        @AppStorage(Defaults.Key.onboard_start.rawValue) private var start = true
        
        var body: some View {
            Card {
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
                    withAnimation(.easeInOut(duration: 0.5)) {
                        start = false
                    }
                }
            }
        }
    }
}
