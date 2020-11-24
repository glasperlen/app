import SwiftUI
import Magister

extension Game.Finish {
    struct Remove: View {
        @Binding var session: Session
        @State private var selected: Magister.Bead?
        @State private var visible = false
        
        var body: some View {
            Card(visible: visible) {
                HStack {
                    Text("You loose!")
                        .font(Font.largeTitle.bold())
                        .padding(.leading)
                        .padding(.top)
                    Spacer()
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.secondarySystemBackground))
                        .frame(width: 120, height: 120)
                    Circle()
                        .fill(Color.black.opacity(0.2))
                        .frame(width: 80, height: 80)
                    if selected != nil {
                        Bead(bead: selected!)
                    }
                }
                .padding(.top, 50)
                Text("This bead will be")
                    .padding(.top)
                Text("removed from your inventory.")
                Spacer()
                Control.Capsule(text: "Done", background: .primary, foreground: .init("Background")) {
                    
                }
                .padding(.bottom)
                .onAppear {
                    guard selected == nil else { return }
                    let bead = session.beads.randomElement()?.item
                    session.beads.removeAll { $0.item == bead }
                    withAnimation(.easeInOut(duration: 1)) {
                        selected = bead
                    }
                }
            }
            .onChange(of: session.match?.state) {
                if $0 == .remove {
                    visible = true
                }
            }
        }
    }
}
