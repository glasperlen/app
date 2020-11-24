import SwiftUI
import Magister

extension Game {
    struct Remove: View {
        @Binding var session: Session
        @State private var selected: Magister.Bead?
        
        var body: some View {
            Card(session: $session, state: .remove) {
                Color("Background")
                    .opacity(0.95)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Game Over")
                        .bold()
                        .padding(.top)
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
                        selected.map { bead in
                            session.beads.removeAll { $0.item == bead }
                            session.match?.removed()
                        }
                    }
                    .padding(.bottom)
                }
                .onAppear {
                    withAnimation(.easeInOut(duration: 1)) {
                        selected = session.beads.filter(\.selected).randomElement()?.item
                    }
                }
            }
        }
    }
}
