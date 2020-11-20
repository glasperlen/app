import SwiftUI
import Magister

extension Game.Finish {
    struct Loose: View {
        @Binding var session: Session
        let done: () -> Void
        @State private var prize: Magister.Bead?
        
        var body: some View {
            HStack {
                Text("You loose!")
                    .font(Font.largeTitle.bold())
                    .padding(.leading)
                    .padding(.top)
                Spacer()
            }
            if prize != nil {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.secondarySystemBackground))
                        .frame(width: 120, height: 120)
                    Circle()
                        .fill(Color.black.opacity(0.2))
                        .frame(width: 80, height: 80)
                    Bead(bead: prize!)
                }
                .padding(.top, 50)
            }
            Text("This bead will be")
                .padding(.top)
            Text("removed from your inventory.")
            Spacer()
            Control.Capsule(text: "Done", background: .primary, foreground: .init("Background"), action: done)
                .padding(.bottom)
                .onAppear {
                    guard prize == nil else { return }
                    let bead = session.beads.randomElement()?.item
                    session.beads.removeAll { $0.item == bead }
                    withAnimation(.easeInOut(duration: 1)) {
                        prize = bead
                    }
                }
        }
    }
}
